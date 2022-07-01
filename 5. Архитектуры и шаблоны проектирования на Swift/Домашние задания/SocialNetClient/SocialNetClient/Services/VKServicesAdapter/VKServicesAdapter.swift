//
//  VKServicesAdapter.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.06.2022.
//

import Foundation
import RealmSwift

//MARK: VKServicesAdapter class declaration

final class VKServicesAdapter {
    
    //MARK: - Properties
    
    private let service = VKServicesProxy(vkService: VKServices())
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    //MARK: - Methods
    
    func getFriends(then completion: @escaping ([UserFriend]) -> Void) {
        guard let realm = try? Realm(),
              let userID = Session.instance.userID,
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: Session.instance.userID)
        else { return }
        
        var userFriends = [UserFriend]()
        let realmFriendsData = vkUser.friends
        
        self.realmNotificationTokens[userID]?.invalidate()
        
        let token = realmFriendsData.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .update(_, _, _, _):
                
                let realmFriendList = Array(realmFriendsData)
                for realmFriend in realmFriendList {
                    let userFriend = UserFriend(realmFriend)
                    userFriends.append(userFriend)
                }
                
                completion(userFriends)
                
            case .error(let error):
                fatalError("\(error)")
                
            case .initial:
                break
            }
        }
        
        self.realmNotificationTokens[userID] = token
        
        service.fetchVKData(ofType: .friends)
    }
    
    func getPhotos(forUser userID: String, then completion: @escaping ([UserPhoto]) -> Void) {
        service.fetchVKData(ofType: .photos, withUserId: userID)
        
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: String(userID))
        else { return }
        
        var userPhotos = [UserPhoto]()
        let realmPhotoData = vkUser.photos
        
        self.realmNotificationTokens[userID]?.invalidate()
        
        let token = realmPhotoData.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .update(_, _, _, _):
                for realmPhoto in realmPhotoData {
                    let userPhoto = UserPhoto(realmPhoto)
                    userPhotos.append(userPhoto)
                }
                completion(userPhotos)
            
            case .error(let error):
                fatalError("\(error)")
                
            case .initial:
                break
            }
        }
        
        self.realmNotificationTokens[userID] = token
    }
    
    func getGroups(forUser userID: String, then completion: @escaping ([Group]) -> Void) {
        service.fetchVKData(ofType: .groups, withUserId: userID)
        
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: Session.instance.userID)
        else { return }
        
        let realmGroups = vkUser.groups
        var userGroups = [Group]()
        
        self.realmNotificationTokens[userID]?.invalidate()
        
        let token = realmGroups.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .update(_, _, _, _):
                for realmGroup in realmGroups {
                    let group = Group(realmGroup)
                    userGroups.append(group)
                }
                completion(userGroups)
                
            case .error(let error):
                fatalError("\(error)")
            
            case .initial:
                break
            }
        }
        
        self.realmNotificationTokens[userID] = token
    }
    
    func getSearchedGroups(withQuery query: String, then completion: @escaping ([Group]) -> Void) {
        service.fetchVKData(ofType: .searchGroups, withQuery: query)
        let key = Session.instance.realmUserKeyForGroupSearch
        
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: key)
        else { return }
        
        let realmGroups = vkUser.groups
        var userGroups = [Group]()
        
        self.realmNotificationTokens[key]?.invalidate()
        
        let token = realmGroups.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .update(_, _, _, _):
                for realmGroup in realmGroups {
                    let group = Group(realmGroup)
                    userGroups.append(group)
                }
                completion(userGroups)
                
            case .error(let error):
                fatalError("\(error)")
            
            case .initial:
                break
            }
        }
        
        self.realmNotificationTokens[key] = token
    }
}
