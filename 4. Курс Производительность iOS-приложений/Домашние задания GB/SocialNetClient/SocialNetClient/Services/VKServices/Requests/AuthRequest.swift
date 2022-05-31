//
//  AuthRequest.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 16.05.2022.
//

import Foundation
import RealmSwift

final class AuthRequest {
    
    public func getAuthForm() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8078935"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups, wall"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        
        guard let url = urlComponents.url else { return nil }
        
        return URLRequest(url: url)
    }
}

