//
//  RealmStorage.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 06.05.2022.
//

import Foundation
import RealmSwift

//MARK: - RealmStorage (Singleton) class declaration

final class RealmStorage: NSObject {
    
    //MARK: - Type properties
    
    static let shared = RealmStorage()
    
    //MARK: - Private properties
    
    private let realmUserKey = Session.instance.realmUserKeyForGroupSearch
    
    //MARK: - Private initializer
    
    private override init() {
        super.init()
    }
    
    //MARK: - Public methods
    
    func saveFriendsData(_ friends: [VKUserFriend]) {
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
    
    func savePhotos(_ photos: [VKUserPhoto], _ userId: String) {
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
    
    func saveAllGroupsData(_ groups: [VKUserGroup]) {
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
    
    func saveGroupsSearchResult(_ groups: [VKUserGroup]) {
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
    
    func deleteGroupsSearchResult() {
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
    
    func saveNewsFeed(_ news: [VKUserNews]) {
        do {
            let realm = try Realm()
            guard let vkUser = realm.object(ofType: VKUser.self,
                                            forPrimaryKey: Session.instance.userID) else { return }
            
            let oldNewsData = vkUser.news
            
            realm.beginWrite()
            realm.delete(oldNewsData)
            vkUser.news.append(objectsIn: news)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    func createUserIfNecessary(with userId: String) {
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
    
    func addNewMainUserIfNecessary(with userId: String) {
        let storage = UserDefaults.standard
        let storageKey = "userID"
        let currentUserID = storage.object(forKey: storageKey) as? String
        
        if userId != currentUserID {
            storage.set(userId, forKey: storageKey)

            let currentUser = VKUser()
            currentUser.userId = userId
            
            do {
                let realm = try Realm()
                let oldUsers = realm.objects(VKUser.self)
                
                realm.beginWrite()
    
                for user in oldUsers {
                    let oldGroupsData = user.groups
                    let oldFriendsData = user.friends
                    let oldPhotosData = user.photos
                    for photo in oldPhotosData {
                        realm.delete(photo.sizes)
                    }
                    realm.delete(oldPhotosData)
                    realm.delete(oldFriendsData)
                    realm.delete(oldGroupsData)
                }
                realm.delete(oldUsers)
                
                realm.add(currentUser)
                try realm.commitWrite()
            }
            catch {
                print(error)
            }
        }
    }
}
