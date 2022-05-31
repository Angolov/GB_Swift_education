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
        return sectionChars.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionChar = sectionChars[section]
        guard let friendsForSection = friendsInSectionList[sectionChar] else { return 0 }
        return friendsForSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sectionChars[section])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        
        let letterLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        letterLabel.textColor = .black.withAlphaComponent(0.5)
        letterLabel.text = String(sectionChars[section])
        letterLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        headerView.addSubview(letterLabel)
        
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var result = [String]()
        for char in sectionChars {
            result.append(String(char))
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseIdentifier,
                                                       for: indexPath) as? FriendCell,
              let friendsForSection = friendsInSectionList[sectionChars[indexPath.section]]
        else { return UITableViewCell() }
        
        let friend = friendsForSection[indexPath.row]
        
        cell.configure(friend: friend) { [weak self] in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromFriendsListToFriendGallery,
                         sender: indexPath.row)
        }
        
        let avatarImage = photoservice?.photo(atIndexpath: indexPath, byUrl: friend.avatarImageName)
        cell.avatarView.configure(image: avatarImage)
        return cell
    }
}
