//
//  VKServices.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 18.02.2022.
//

import Foundation

//MARK: - VKServices class declaration
final class VKServices {
    
    //MARK: - Private properties
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    private let scheme = "https"
    private let host = "api.vk.com"
    private let path = "/method/"
    private let apiVersion = URLQueryItem(name: "v", value: "5.131")
    
    //MARK: - VKMethods enum declaration
    enum VKMethods: String {
        case friendsGet = "friends.get"
        case photosGetAll = "photos.getAll"
        case groupsGet = "groups.get"
        case groupsSearch = "groups.search"
        case newsfeed = "newsfeed.get"
    }
    
    //MARK: - Public methods
    func createDataTask(with method: VKMethods,
                  params: [URLQueryItem],
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        
        var queryItems = params
        queryItems.append(apiVersion)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path + method.rawValue
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: completion)
        return task
    }
}

//MARK: - VKServices extension for VK data fetching
extension VKServices {
    
    //MARK: - VKDataType enum declaration
    enum VKDataType {
        case friends
        case photos
        case groups
        case searchGroups
        case newsfeed
    }
    
    func fetchVKData(ofType dataType: VKDataType, withUserId userId: String = "", withQuery query: String = "") {
        switch dataType {
        case .friends:
            let request = FriendsRequest()
            request.getAllFriends()
            
        case .photos:
            let request = PhotosRequest()
            request.getAllPhotos(for: userId)
            
        case .groups:
            let request = GroupsRequest()
            request.getUserGroups(for: userId)
            
        case .searchGroups:
            let request = SearchGroupsRequest()
            request.getGroupsBy(searchQuery: query)
            
        case .newsfeed:
            let request = NewsfeedRequest()
            request.getNewsfeed()
        }
    }
}
