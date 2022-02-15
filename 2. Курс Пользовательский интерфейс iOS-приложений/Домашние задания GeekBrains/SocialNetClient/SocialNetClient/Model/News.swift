//
//  News.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import Foundation

//MARK: - NewsProtocol declaration
protocol NewsProtocol {
    
    var authorName: String { get set }
    var authorAvatarImageName: String { get set }
    var date: Date { get set }
    var dateInString: String { get set }
    var photosNames: [String] { get set }
    var text: String { get set }
    var likes: Int { get set }
    var isLiked: Bool { get set }
    var views: Int { get set }
}

//MARK: - News struct declaration
struct News: NewsProtocol {
    
    var authorName: String
    var authorAvatarImageName: String
    var date: Date
    var dateInString: String
    var photosNames: [String]
    var text: String
    var likes: Int
    var isLiked: Bool
    var views: Int
}
