//
//  User.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import Foundation
import UIKit

//MARK: - UserProtocol declaration
protocol UserProtocol {
    
    var name: String { get set }
    var avatar: UIImage { get set }
    var photos: [UIImage] { get set }
    var likes: [Int] { get set }
    var isLiked: [Bool] { get set }
    var avatarImageName: String { get set }
    var photosImageNames: [String] { get set }
}

//MARK: - User struct declaration
struct User: UserProtocol {
    
    var name: String
    var avatar: UIImage
    var photos: [UIImage]
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
        self.avatar = UIImage()
        self.photos = []
        self.likes = likes
        self.isLiked = isLiked

        if let avatarImage = UIImage(named: avatarImageName) {
            self.avatar = avatarImage
        }
        
        photosImageNames.forEach { photoName in
            if let photoImage = UIImage(named: photoName) {
                self.photos.append(photoImage)
            }
        }
    }
}
