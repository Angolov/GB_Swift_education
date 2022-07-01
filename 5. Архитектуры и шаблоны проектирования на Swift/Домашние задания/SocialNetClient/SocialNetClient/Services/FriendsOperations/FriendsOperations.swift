//
//  FriendsOperations.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 07.05.2022.
//

import Foundation

final class FriendsVKRequestOperation: Operation {
    var data: Data?
    
    override func main() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "user_id", value: Session.instance.userID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        guard let response = try? Data(contentsOf: url) else { return }
        data = response
    }
}

final class FriendsDataParsingOperation: Operation {
    var friendList: [VKUserFriend]?
    
    override func main() {
        
        guard let friendsVKRequestOperation = dependencies.first as? FriendsVKRequestOperation,
              let data = friendsVKRequestOperation.data else { return }
        
        do {
            friendList = try JSONDecoder().decode(UserFriendsResponse.self,
                                                   from: data).response.items
        } catch {
            print("Error")
        }
    }
}

final class FriendsDataSaveToStorageOperation: Operation {
    
    override func main() {
        guard let friendsDataParsingOperation = dependencies.first as? FriendsDataParsingOperation,
              let friendList = friendsDataParsingOperation.friendList else { return }
        
        RealmStorage.shared.saveFriendsData(friendList)
    }
}
