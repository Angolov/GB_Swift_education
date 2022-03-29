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
        if searchText.isEmpty {
            friendList = Array(realmFriendsData)
        }
        else {
            friendList = Array(realmFriendsData).filter({ sourceFriendsItem in
                sourceFriendsItem.name.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancelButton.layer.backgroundColor = #colorLiteral(red: 0.09154463559, green: 0.4052957892, blue: 0.7908139825, alpha: 1).cgColor
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.shadowColor = UIColor.black.cgColor
        cancelButton.layer.shadowRadius = 10
        cancelButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        cancelButton.layer.shadowOpacity = 0.7
        cancelButton.setAttributedTitle(NSAttributedString(string: "Cancel",
                                                           attributes: [.font: UIFont.systemFont(ofSize: 11,
                                                                                                 weight: .bold)]),
                                        for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setAttributedTitle(NSAttributedString(string: "Cancel",
                                                           attributes: [.font: UIFont.systemFont(ofSize: 11,
                                                                                                 weight: .bold)]),
                                        for: .highlighted)
        cancelButton.setTitleColor(.lightGray, for: .highlighted)
        
        UIView.animate(withDuration: 0.3) {
            cancelButton.frame = CGRect(x: cancelButton.frame.origin.x - 50,
                                        y: cancelButton.frame.origin.y,
                                        width: cancelButton.frame.width,
                                        height: cancelButton.frame.height)
            searchBar.frame = CGRect(x: searchBar.frame.origin.x,
                                     y: searchBar.frame.origin.y,
                                     width: searchBar.frame.size.width - 1,
                                     height: searchBar.frame.size.height)
            searchBar.layoutSubviews()
        } completion: { isFinished in
            if isFinished {
                searchBar.placeholder = "Введите имя..."
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.placeholder = nil
        friendList = Array(realmFriendsData)
        
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = false
            searchBar.text = nil
            searchBar.resignFirstResponder()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.searchBarAnimateClosure()
        }
    }
}
