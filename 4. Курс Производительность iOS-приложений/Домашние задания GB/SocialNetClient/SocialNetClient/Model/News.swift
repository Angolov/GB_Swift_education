//
//  News.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import Foundation
import RealmSwift

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

//MARK: - UserNewsResponse struct declaration
struct UserNewsResponse: Decodable {
    let response: VKUserNewsItems
}

//MARK: - VKUserNewsItems struct declaration
struct VKUserNewsItems: Decodable {
    let items: [VKUserNews]
    let profiles: [VKUserFriend]
    let groups: [VKUserGroup]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

//MARK: - VKUserNews class declaration
class VKUserNews: Object, NewsProtocol, Decodable {
    @objc dynamic var sourceID: Int = 0
    @objc dynamic var authorName: String = ""
    @objc dynamic var authorAvatarImageName: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var dateInString: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var likes: Int = 0
    @objc dynamic var isLiked: Bool = false
    @objc dynamic var views: Int = 0
    
    var photosNames: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "source_id"
        case date
        case text
        case likes
        case views
        case attachments
    }

    enum LikesKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }

    enum ViewsKeys: String, CodingKey {
        case count
    }
    
    enum AttachmentsKeys: String, CodingKey {
        case type
        case photo
    }
    
    enum PhotoKeys: String, CodingKey {
        case sizes
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.sourceID = try values.decode(Int.self, forKey: .id)
        
        let timestamp = try values.decode(Int.self, forKey: .date)
        let unixDate = Double(timestamp)
        self.date = Date(timeIntervalSince1970: unixDate)
        self.dateInString = DateFormatterHelper.shared.formatter.string(from: self.date)
        
        self.text = try values.decode(String.self, forKey: .text)
        
        let likesContainer = try values.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
        
        let isLikedInInt = try likesContainer.decode(Int.self, forKey: .userLikes)
        self.isLiked = isLikedInInt == 0 ? false : true
        self.likes = try likesContainer.decode(Int.self, forKey: .count)
        
        let viewsContainer = try values.nestedContainer(keyedBy: ViewsKeys.self, forKey: .views)
        self.views = try viewsContainer.decode(Int.self, forKey: .count)
        
        let attachments = try values.decode([NewsAttachments].self, forKey: .attachments)
        for item in attachments {
            if item.type == "photo" {
                for size in item.sizes {
                    if size.type == "x" {
                        self.photosNames.append(size.url)
                    }
                }
            }
        }
    }
}

//MARK: - NewsAttachments class declaration
class NewsAttachments: Decodable {
    
    var type: String = ""
    var sizes: [UserPhotoSize] = []
    
    enum AttachmentsKeys: String, CodingKey {
        case type
        case photo
    }
    
    enum PhotoKeys: String, CodingKey {
        case sizes
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: AttachmentsKeys.self)
        self.type = try values.decode(String.self, forKey: .type)
        if type == "photo" {
            let photoContainer = try values.nestedContainer(keyedBy: PhotoKeys.self, forKey: .photo)
            self.sizes = try photoContainer.decode([UserPhotoSize].self, forKey: .sizes)
        }
    }
}

