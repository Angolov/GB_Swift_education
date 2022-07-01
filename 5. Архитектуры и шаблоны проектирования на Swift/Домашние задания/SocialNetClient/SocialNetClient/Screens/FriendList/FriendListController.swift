//
//  FriendListController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import RealmSwift

//MARK: - FriendListController class declaration

final class FriendListController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: - Properties
    
    private let adapter = VKServicesAdapter()
    
    let fromFriendsListToFriendGallery = "fromFriendsListToFriendGallery"
    
    var photoservice: PhotoService?
    var originalFriendList = [UserProtocol]()
    var friendList = [UserProtocol]() {
        didSet {
            let helper = UserInSectionsHelper()
            friendsInSectionList = helper.getFriendInSections(from: friendList)
            sectionChars = helper.getSectionsChars(from: friendList)
            tableView.reloadData()
        }
    }
    
    lazy var friendsInSectionList: [Character : [UserProtocol]] = {
        let helper = UserInSectionsHelper()
        return helper.getFriendInSections(from: friendList)
    }()
    lazy var sectionChars: [Character] = {
        let helper = UserInSectionsHelper()
        return helper.getSectionsChars(from: friendList)
    }()
    
    lazy var searchBarAnimateClosure: () -> Void = {
        return {
            guard let scopeView = self.searchBar.searchTextField.leftView else { return }
            
            UIView.animate(withDuration: 0.3,
            animations: {
                scopeView.frame = CGRect(x: self.searchBar.frame.width / 2 - 15,
                                         y: scopeView.frame.origin.y,
                                         width: scopeView.frame.width,
                                         height: scopeView.frame.height)
                self.searchBar.layoutSubviews()
            })
        }()
    }
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FriendCell", bundle: nil),
                           forCellReuseIdentifier: FriendCell.reuseIdentifier)
        tableView.sectionHeaderTopPadding = 0
        searchBar.delegate = self
        self.navigationController?.delegate = self
        photoservice = PhotoService(container: tableView)
        
        adapter.getFriends { [weak self] friends in
            guard let strongSelf = self else { return }
            strongSelf.originalFriendList = friends
            strongSelf.friendList = friends
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBarAnimateClosure()
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsListToFriendGallery,
           let destinationController = segue.destination as? FriendGalleryController,
           let id = sender as? Int {
            destinationController.userID = id
        }
    }
}
