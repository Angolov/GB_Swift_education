//
//  FriendListController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - FriendListController class declaration
final class FriendListController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let sourceFriendList = Storage.shared.friends
    var friendList = [UserProtocol]()
    
    //MARK: - Properties
    let reuseIdentifierFriendCell = "reuseIdentifierFriendCell"
    let fromFriendsListToFriendGallery = "fromFriendsListToFriendGallery"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FriendCell", bundle: nil),
                           forCellReuseIdentifier: reuseIdentifierFriendCell)
        searchBar.delegate = self
        friendList = sourceFriendList
        
        self.navigationController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsListToFriendGallery,
           let destinationController = segue.destination as? FriendGalleryController,
           let index = sender as? Int {
            destinationController.friendIndex = index
        }
    }
}
