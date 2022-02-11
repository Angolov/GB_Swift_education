//
//  FriendsModel.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit


// Создадим модель для добавлении друзей в массив друзей
struct FriendModel {
    let name: String
    let image: String
    let uiImage: UIImage
    var friendsPhoto: [UIImage] = []
    
    init(name: String, image: String, friendsPhoto: [String]) {
        self.name = name
        self.image = image
        
        uiImage = UIImage(named: image) ?? UIImage()
        
        // массив фоток друзей из имен фоток
        for friendsPhoto in friendsPhoto {
            guard let image = UIImage(named: friendsPhoto) else {continue}
            self.friendsPhoto.append(image)
        }
    }
}
