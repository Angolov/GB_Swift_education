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
        return UIConstants.heightForFriendCellTableView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let friendsInSection = friendsInSectionList[sectionChars[indexPath.section]] else { return }
        let userId = friendsInSection[indexPath.row].userId
        performSegue(withIdentifier: fromFriendsListToFriendGallery, sender: userId)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FriendCell {
            cell.animate()
        }
    }
}
