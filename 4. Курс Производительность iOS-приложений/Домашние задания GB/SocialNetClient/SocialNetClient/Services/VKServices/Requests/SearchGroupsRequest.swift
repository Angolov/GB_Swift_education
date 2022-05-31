//
//  SearchGroupsRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation

//MARK: - SearchGroupsRequest class declaration
final class SearchGroupsRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    private let realmUserKey = Session.instance.realmUserKeyForGroupSearch
    
    //MARK: - Public methods
    func getGroupsBy(searchQuery: String) {
        
        let storage = RealmStorage.shared
        storage.createUserIfNecessary(with: realmUserKey)
        
        guard searchQuery != ""
        else {
            storage.deleteGroupsSearchResult()
            return
        }
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "q", value: searchQuery)
        ]
        
        let task = services.createDataTask(with: .groupsSearch, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let groups = try JSONDecoder().decode(UserGroupsResponse.self, from: data).response.items
                storage.saveGroupsSearchResult(groups)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
}
