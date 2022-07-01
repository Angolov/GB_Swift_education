//
//  PhotosRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation

//MARK: - PhotosRequest class declaration

final class PhotosRequest {
    
    //MARK: - Private properties
    
    private let services = VKServices()
    
    //MARK: - Public methods
    
    func getAllPhotos(for userId: String) {
        
        let storage = RealmStorage.shared
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "owner_id", value: userId),
            URLQueryItem(name: "extended", value: "1")
        ]
        
        storage.createUserIfNecessary(with: userId)
        
        let task = services.createDataTask(with: .photosGetAll, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let photos = try JSONDecoder().decode(UserPhotosResponse.self,
                                                      from: data).response.items
                storage.savePhotos(photos, userId)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
}
