//
//  NewsfeedRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 24.03.2022.
//

import Foundation
import SwiftyJSON

//MARK: - NewsfeedRequest class declaration

final class NewsfeedRequest {
    
    //MARK: - Private properties
    
    private let services = VKServices()
    
    //MARK: - Public methods
    
    func getNewsfeed(startTime: TimeInterval? = nil, startFrom: String? = nil, _ completion: @escaping ([VKUserNews], String) -> Void) {
        
        var queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "5")
        ]
        
        if let startTime = startTime {
            queryItems.append(URLQueryItem(name: "start_time", value: String(startTime)))
        }
        
        if startFrom != nil {
            queryItems.append(URLQueryItem(name: "start_from", value: startFrom))
        }
        
        let task = services.createDataTask(with: .newsfeed, params: queryItems) { data, response, error in
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                
                let dispatchGroup = DispatchGroup()
                let decoder = JSONDecoder()
                
                let newsItemsArr = json["response"]["items"].arrayValue
                let profilesItemsArr = json["response"]["profiles"].arrayValue
                let groupsItemsArr = json["response"]["groups"].arrayValue
                let nextFrom = json["response"]["next_from"].stringValue
                
                var news: [VKUserNews] = []
                var profiles: [VKUserFriend] = []
                var groups: [VKUserGroup] = []
                
                DispatchQueue.global().async(group: dispatchGroup) {
                    for (index, items) in newsItemsArr.enumerated() {
                        do {
                            let decodedItem = try decoder.decode(VKUserNews.self, from: items.rawData())
                            news.append(decodedItem)
                        } catch (let error) {
                            print("Item decoding error at index \(index), error: \(error)")
                        }
                    }
                }
                
                DispatchQueue.global().async(group: dispatchGroup) {
                    for (index, items) in profilesItemsArr.enumerated() {
                        do {
                            let decodedItem = try decoder.decode(VKUserFriend.self, from: items.rawData())
                            profiles.append(decodedItem)
                        } catch (let error) {
                            print("Profile decoding error at index \(index), error: \(error)")
                        }
                    }
                }
                
                DispatchQueue.global().async(group: dispatchGroup) {
                    for (index, items) in groupsItemsArr.enumerated() {
                        do {
                            let decodedItem = try decoder.decode(VKUserGroup.self, from: items.rawData())
                            groups.append(decodedItem)
                        } catch (let error) {
                            print("Group decoding error at index \(index), error: \(error)")
                        }
                    }
                }
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
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
                    
                    completion(news, nextFrom)
                }
            }
            catch {
                print("Error")
            }
        }
        task?.resume()
    }
}
