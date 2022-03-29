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
    private let services = VKServices()
    
    let fromFriendsListToFriendGallery = "fromFriendsListToFriendGallery"
    
    var token: NotificationToken?
    var realmFriendsData = List<VKUserFriend>()
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
        return helper.getFriendInSections(from: Array(realmFriendsData))
    }()
    lazy var sectionChars: [Character] = {
        let helper = UserInSectionsHelper()
        return helper.getSectionsChars(from: Array(realmFriendsData))
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
        
        services.fetchVKData(ofType: .friends)
        pairTableViewAndRealm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBarAnimateClosure()
    }
    
    //MARK: - Private methods
    private func pairTableViewAndRealm() {
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: Session.instance.userID)
        else { return }
        
        realmFriendsData = vkUser.friends
        
        token = realmFriendsData.observe { [weak self] (changes: RealmCollectionChange) in
            guard let strongSelf = self else { return }

            switch changes {
            case .initial, .update(_, _, _, _):
                strongSelf.friendList = Array(strongSelf.realmFriendsData)
                
            case .error(let error):
                fatalError("\(error)")
            }
        }
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
