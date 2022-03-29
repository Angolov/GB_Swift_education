//
//  Session.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 13.02.2022.
//

import Foundation

//MARK: - Session (Singleton) class declaration
final class Session {
    
    //MARK: - Type properties
    static let instance = Session()
    
    //MARK: - Public properties
    let realmUserKeyForGroupSearch = "groupSearchQuery"
    var token: String?
    var userID: String?
    
    //MARK: - Private initializer
    private init() {}
}
