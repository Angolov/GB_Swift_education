//
//  NewsfeedRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 24.03.2022.
//

import Foundation
import RealmSwift

//MARK: - NewsfeedRequest class declaration
final class NewsfeedRequest {
    
    //MARK: - Private properties
    private let services = VKServices()
    
    //MARK: - Public methods
    func getNewsfeed() {
        
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "10")
        ]
        
        let task = services.createDataTask(with: .newsfeed, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(UserNewsResponse.self, from: data).response
                let news = response.items
                let profiles = response.profiles
                let groups = response.groups
                
                for item in news {
                    let sourceID = item.sourceID
                    
                    if sourceID > 0 {
                        for profile in profiles {
                            if profile.userId == sourceID {
                                item.authorName = profile.name
                                item.authorAvatarImageName = profile.avatarImageName
                                break
                            }
                        }
                    }
                    else {
                        for group in groups {
                            if group.id == -sourceID {
                                item.authorName = group.name
                                item.authorAvatarImageName = group.avatarImageName
                                break
                            }
                        }
                    }
                }
                
                self.saveNewsFeed(news)
            }
            catch {
                print("Error")
            }
        }
        task?.resume()
    }
    
    //MARK: - Private methods
    private func saveNewsFeed(_ news: [VKUserNews]) {
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
}
