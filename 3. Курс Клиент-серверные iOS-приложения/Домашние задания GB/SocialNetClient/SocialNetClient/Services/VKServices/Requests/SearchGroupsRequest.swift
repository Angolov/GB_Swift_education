//
//  SearchGroupsRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation
import RealmSwift

//MARK: - SearchGroupsRequest class declaration
final class SearchGroupsRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    private let realmUserKey = Session.instance.realmUserKeyForGroupSearch
    
    //MARK: - Public methods
    func getGroupsBy(searchQuery: String) {
        
        createUserIfNecessary()
        guard searchQuery != ""
        else {
            deleteGroupsSearchResult()
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
                self.saveGroupsSearchResult(groups)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
    
    //MARK: - Private methods
    private func createUserIfNecessary() {
        do {
            let realm = try Realm()
            let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: realmUserKey)
            
            if vkUser == nil {
                realm.beginWrite()
                let newUser = VKUser()
                newUser.userId = realmUserKey
                realm.add(newUser)
                try realm.commitWrite()
            }
        }
        catch {
            print(error)
        }
    }
    
    private func saveGroupsSearchResult(_ groups: [VKUserGroup]) {
        do {
            let realm = try Realm()
            guard let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: realmUserKey) else { return }
            
            realm.beginWrite()
            let oldGroupsData = vkUser.groups
            realm.delete(oldGroupsData)
            vkUser.groups.append(objectsIn: groups)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    private func deleteGroupsSearchResult() {
        do {
            let realm = try Realm()
            guard let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: realmUserKey) else { return }
            
            realm.beginWrite()
            let oldGroupsData = vkUser.groups
            realm.delete(oldGroupsData)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
