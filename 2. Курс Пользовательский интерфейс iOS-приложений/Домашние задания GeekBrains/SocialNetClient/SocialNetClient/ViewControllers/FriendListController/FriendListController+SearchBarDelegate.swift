//
//  File.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 16.01.2022.
//

import UIKit

//MARK: - Extension of FriendListController for UISearchBarDelegate
extension FriendListController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let helper = UserInSectionsHelper()
        
        if searchText.isEmpty {
            friendList = sourceFriendList
            
        } else {
            friendList = sourceFriendList.filter({ sourceFriendsItem in
                sourceFriendsItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        friendsInSectionList = helper.getFriendInSections(from: friendList)
        sectionChars = helper.getSectionsChars(from: friendList)
        
        tableView.reloadData()
    }
}
