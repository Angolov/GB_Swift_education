//
//  NewsMainModel.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

struct NewsMainViewCellModel {
    
    var nameFriend: FriendModel
    var postDate: String
    var postText: String
    var newsImageNames: [String]
    var collection: [CollectionCellModel] = []
    
    init(nameFriend: FriendModel, postDate: String, postText: String, newsImageNames: [String]) {
        self.nameFriend = nameFriend
        self.postDate = postDate
        self.postText = postText
        self.newsImageNames = newsImageNames
        
        for newsImage in newsImageNames {
            guard let image = UIImage(named: newsImage) else {continue}
            self.collection.append(CollectionCellModel(image: image))
        }
    }
}
