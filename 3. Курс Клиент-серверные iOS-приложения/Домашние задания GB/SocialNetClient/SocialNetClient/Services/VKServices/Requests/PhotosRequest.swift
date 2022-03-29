//
//  PhotosRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation
import RealmSwift

//MARK: - PhotosRequest class declaration
final class PhotosRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    
    //MARK: - Public methods
    func getAllPhotos(for userId: String) {
        
        createUserIfNecessary(with: userId)
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "owner_id", value: userId),
            URLQueryItem(name: "extended", value: "1")
        ]
        
        let task = services.createDataTask(with: .photosGetAll, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let photos = try JSONDecoder().decode(UserPhotosResponse.self,
                                                      from: data).response.items
                self.saveAllPhotos(photos, userId)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
    
    //MARK: - Private methods
    private func createUserIfNecessary(with userId: String) {
        do {
            let realm = try Realm()
            let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: userId)
            
            if vkUser == nil {
                realm.beginWrite()
                let newUser = VKUser()
                newUser.userId = userId
                realm.add(newUser)
                try realm.commitWrite()
            }
        }
        catch {
            print(error)
        }
    }
    
    private func saveAllPhotos(_ photos: [VKUserPhoto], _ userId: String) {
        do {
            let realm = try Realm()
            guard let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: userId) else { return }
            
            realm.beginWrite()
            
            let oldPhotos = vkUser.photos
            for photo in oldPhotos {
                realm.delete(photo.sizes)
            }
            realm.delete(oldPhotos)
            vkUser.photos.append(objectsIn: photos)
            
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
