//
//  UserPhotos.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 20.02.2022.
//

import Foundation
import RealmSwift

//MARK: - UserFriendsResponse struct declaration

struct UserPhotosResponse: Decodable {
    let response: UserPhotosItems
}

//MARK: - UserFriendsItems struct declaration

struct UserPhotosItems: Decodable {
    let items: [VKUserPhoto]
}

//MARK: - VKUserPhoto class declaration

class VKUserPhoto: Object, Decodable {
    var sizes = List<UserPhotoSize>()
    @objc dynamic var isLiked: Bool = false
    @objc dynamic var likes: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case sizes
        case likes
    }
    
    enum LikesKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let likesContainer = try values.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
        
        let isLikedInInt = try likesContainer.decode(Int.self, forKey: .userLikes)
        self.isLiked = isLikedInInt == 0 ? false : true
        
        self.likes = try likesContainer.decode(Int.self, forKey: .count)
        
        let userPhotoSizes = try values.decode([UserPhotoSize].self, forKey: .sizes)
        self.sizes.append(objectsIn: userPhotoSizes)
    }
}

//MARK: - UserPhotoSize class declaration

class UserPhotoSize: Object, Decodable {
    
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    
    enum CodingKeys: String, CodingKey {
        case url
        case type
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try values.decode(String.self, forKey: .url)
        self.type = try values.decode(String.self, forKey: .type)
    }
}

//MARK: - UserPhoto class declaration

class UserPhoto {
    var sizes = [UserPhotoSize]()
    var isLiked: Bool = false
    var likes: Int = 0
    
    init(_ vkUserPhoto: VKUserPhoto) {
        self.sizes = Array(vkUserPhoto.sizes)
        self.isLiked = vkUserPhoto.isLiked
        self.likes = vkUserPhoto.likes
    }
}
