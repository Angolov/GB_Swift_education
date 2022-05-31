//
//  UserHelper.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 13.02.2022.
//

import Foundation

//MARK: - UserInSectionsHelper class declaration
final class UserInSectionsHelper {
    
    func getFriendInSections(from friends: [UserProtocol]) -> [Character : [UserProtocol]] {
        
        var result: [Character : [UserProtocol]] = [:]
        var friendsArray = friends
        
        friendsArray.sort { $0.name < $1.name }
        
        for friend in friendsArray {
            guard let firstCharOfName = friend.name.first else { continue }
            
            if var friendsInSection = result[firstCharOfName] {
                friendsInSection.append(friend)
                result.updateValue(friendsInSection, forKey: firstCharOfName)
            } else {
                result.updateValue([friend], forKey: firstCharOfName)
            }
        }
        
        return result
    }
    
    func getSectionsChars(from friends: [UserProtocol]) -> [Character] {
        
        var result: [Character] = []
        
        for friend in friends {
            guard let firstCharOfName = friend.name.first else { continue }
            if !result.contains(firstCharOfName) {
                result.append(firstCharOfName)
            }
        }
        
        result.sort { $0 < $1 }
        
        return result
    }
}
