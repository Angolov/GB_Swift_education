//
//  UserPhotosViewModel.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.06.2022.
//

import Foundation

//MARK: - UserPhotosViewModel class declaration

final class UserPhotosViewModel {
    
    //MARK: - Properties
    
    var imageURL: URL
    var isLiked: Bool
    var likes: Int
    
    //MARK: - Initializer
    
    init(imageURL: URL, isLiked: Bool, likes: Int) {
        self.imageURL = imageURL
        self.isLiked = isLiked
        self.likes = likes
    }
}
