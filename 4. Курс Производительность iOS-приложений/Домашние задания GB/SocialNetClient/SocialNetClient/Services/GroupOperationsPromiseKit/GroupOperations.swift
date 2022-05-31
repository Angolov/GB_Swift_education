//
//  GroupOperations.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 11.05.2022.
//

import Foundation
import PromiseKit

enum GroupsDataError: Error {
    case failedToFetchData
    case failedToParseData
}

final class GroupsVKRequestPromises {
    
    func getUserGroups(for user: String) -> Promise<Data> {

        return Promise<Data> { seal in
            
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/groups.get"
            urlComponents.queryItems = [
                URLQueryItem(name: "access_token", value: Session.instance.token),
                URLQueryItem(name: "user_id", value: user),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "fields", value: "description"),
                URLQueryItem(name: "v", value: "5.131")
            ]
            
            if let url = urlComponents.url,
               let response = try? Data(contentsOf: url) {
                seal.fulfill(response)
            } else {
                seal.reject(GroupsDataError.failedToFetchData)
            }
        }
    }
    
    func parseGroupsData(_ data: Data) -> Promise<[VKUserGroup]> {
        
        return Promise<[VKUserGroup]> { seal in
            
            if let groups = try? JSONDecoder().decode(UserGroupsResponse.self, from: data).response.items {
                seal.fulfill(groups)
            } else {
                seal.reject(GroupsDataError.failedToParseData)
            }
        }
    }
    
    func saveGroupsData(_ groups: [VKUserGroup]) {
        let storage = RealmStorage.shared
        storage.saveAllGroupsData(groups)
    }
    
}
