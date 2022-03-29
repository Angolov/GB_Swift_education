//
//  User.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import Foundation
import RealmSwift

//MARK: - UserProtocol declaration
protocol UserProtocol {
    
    var userId: Int { get set }
    var name: String { get set }
    var avatarImageName: String { get set }
}

//MARK: - User struct declaration
struct User: UserProtocol {
    
    var userId: Int = 0
    var name: String
    var likes: [Int]
    var isLiked: [Bool]
    var avatarImageName: String
    var photosImageNames: [String]
    
    init(name: String,
         avatarImageName: String,
         photosImageNames: [String],
         likes: [Int],
         isLiked: [Bool]) {
        
        self.name = name
        self.avatarImageName = avatarImageName
        self.photosImageNames = photosImageNames
        self.likes = likes
        self.isLiked = isLiked
    }
}

//MARK: - UserFriendsResponse struct declaration
struct UserFriendsResponse: Decodable {
    let response: UserFriendsItems
}

//MARK: - UserFriendsItems struct declaration
struct UserFriendsItems: Decodable {
    let items: [VKUserFriend]
}

//MARK: - VKUser class declaration
class VKUser: Object {

    @objc dynamic var userId: String = ""
    let friends = List<VKUserFriend>()
    let groups = List<VKUserGroup>()
    let photos = List<VKUserPhoto>()
    let news = List<VKUserNews>()
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}

//MARK: - VKUserFriend class declaration
class VKUserFriend: Object, Decodable, UserProtocol {
    
    @objc dynamic var userId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarImageName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
    
//    override static func primaryKey() -> String? {
//        return "userId"
//    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try values.decode(Int.self, forKey: .id)
        
        let firstName = try values.decode(String.self, forKey: .firstName)
        let lastName = try values.decode(String.self, forKey: .lastName)
        self.name = firstName + " " + lastName
        
        self.avatarImageName = try values.decode(String.self, forKey: .photo)
    }
}

