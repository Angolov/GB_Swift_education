//
//  FriendsSection.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

// Создадим модель для сортировки друзей по ключу

struct FriendsSection: Comparable {
    var key: Character
    var data: [FriendModel]
    
    static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key < rhs.key
    }
    
    static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key == rhs.key
    }
}
