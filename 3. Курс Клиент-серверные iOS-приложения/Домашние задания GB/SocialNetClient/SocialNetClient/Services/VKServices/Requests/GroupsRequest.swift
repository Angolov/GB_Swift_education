//
//  GroupsRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import Foundation
import RealmSwift

//MARK: - GroupsRequest class declaration
final class GroupsRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    
    //MARK: - Public methods
    func getUserGroups(for user: String) {
        
        print(user)
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "user_id", value: user),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description")
        ]
        let task = services.createDataTask(with: .groupsGet, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let groups = try JSONDecoder().decode(UserGroupsResponse.self, from: data).response.items
                self.saveAllGroupsData(groups)
            } catch {
                print("Error")
            }
        }
        task?.resume()
    }
    
    //MARK: - Private methods
    private func saveAllGroupsData(_ groups: [VKUserGroup]) {
        do {
            let realm = try Realm()
            guard let vkUser = realm.object(ofType: VKUser.self,
                                            forPrimaryKey: Session.instance.userID) else { return }
            let oldGroupsData = vkUser.groups
            realm.beginWrite()
            realm.delete(oldGroupsData)
            vkUser.groups.append(objectsIn: groups)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
