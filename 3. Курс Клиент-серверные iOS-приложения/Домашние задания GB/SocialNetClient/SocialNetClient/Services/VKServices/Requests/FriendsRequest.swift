//
//  FriendsRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation
import RealmSwift

//MARK: - FriendsRequest class declaration
final class FriendsRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    
    //MARK: - Public methods
    func getAllFriends() {
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "name_case", value: "nom")
        ]
        
        let task = services.createDataTask(with: .friendsGet, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let friends = try JSONDecoder().decode(UserFriendsResponse.self,
                                                       from: data).response.items
                self.saveAllFriendsData(friends)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
    
    //MARK: - Private methods
    private func saveAllFriendsData(_ friends: [VKUserFriend]) {
        do {
            let realm = try Realm()
            guard let vkUser = realm.object(ofType: VKUser.self,
                                            forPrimaryKey: Session.instance.userID) else { return }
            let oldFriendsData = vkUser.friends
            realm.beginWrite()
            realm.delete(oldFriendsData)
            vkUser.friends.append(objectsIn: friends)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
