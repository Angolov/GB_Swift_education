//
//  FriendsRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation

//MARK: - FriendsRequest class declaration
final class FriendsRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    
    //MARK: - Public methods
    func getAllFriends() {
        
        let storage = RealmStorage.shared
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
                
                storage.saveFriendsData(friends)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
}
