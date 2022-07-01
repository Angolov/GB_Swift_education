//
//  Group.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import Foundation
import RealmSwift

//MARK: - GroupProtocol declaration

protocol GroupProtocol {
    
    var name: String { get set }
    var avatarImageName: String { get set }
    var groupDescription: String { get set }
}

//MARK: - Group struct declaration

struct Group: GroupProtocol {
    
    var name: String
    var avatarImageName: String
    var groupDescription: String
    
    init(_ vkUserGroup: VKUserGroup) {
        self.name = vkUserGroup.name
        self.avatarImageName = vkUserGroup.avatarImageName
        self.groupDescription = vkUserGroup.groupDescription
    }
}

//MARK: - UserGroupsResponse struct declaration

struct UserGroupsResponse: Decodable {
    let response: UserGroupsItems
}

//MARK: - UserGroupsItems struct declaration

struct UserGroupsItems: Decodable {
    let items: [VKUserGroup]
}

//MARK: - VKUserGroup class declaration

class VKUserGroup: Object, Decodable, GroupProtocol {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarImageName: String = ""
    @objc dynamic var groupDescription: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_200"
        case description
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.avatarImageName = try values.decode(String.self, forKey: .photo)
        
        do {
            self.groupDescription = try values.decode(String.self, forKey: .description)
        }
        catch {
            //print("No description")
        }
    }
}
