//
//  FriendListController+TableViewDataSource.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of FriendListController for UITableViewDataSource
extension FriendListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierFriendCell,
                                                       for: indexPath) as? FriendCell else { return UITableViewCell() }
        
        cell.configure(friend: friendList[indexPath.row]) { [weak self] in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromFriendsListToFriendGallery,
                         sender: indexPath.row)
        }
        return cell
    }
}
