//
//  FriendListController+TableViewDelegeta.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of FriendListController for UITableViewDelegate
extension FriendListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForFriendCellTableView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var index = 0
        for i in 0..<indexPath.section {
            guard let itemsCount = friendsInSectionList[sectionChars[i]]?.count else { continue }
            index += itemsCount
        }
        index += indexPath.row
        
        performSegue(withIdentifier: fromFriendsListToFriendGallery,
                     sender: index)
    }
}
