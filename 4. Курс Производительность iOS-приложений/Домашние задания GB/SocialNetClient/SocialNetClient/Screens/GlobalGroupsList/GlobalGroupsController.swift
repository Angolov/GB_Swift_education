//
//  GlobalGroupsController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import RealmSwift

//MARK: - GlobalGroupsController class declaration
final class GlobalGroupsController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    let services = VKServices()
    let realmUserKey = Session.instance.realmUserKeyForGroupSearch
    var doAfterGroupSelected: ((GroupProtocol) -> Void)?
    var searchedGroups = List<VKUserGroup>()
    var token: NotificationToken?
    
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
        tableView.register(UINib(nibName: "GroupCell", bundle: nil),
                           forCellReuseIdentifier: GroupCell.reuseIdentifier)
        searchBar.delegate = self
        
        services.fetchVKData(ofType: .searchGroups, withQuery: "")
        pairTableViewAndRealm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBarAnimateClosure()
    }
    
    //MARK: - Private methods
    private func pairTableViewAndRealm() {
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: realmUserKey)
        else { return }
        searchedGroups = vkUser.groups
        
        token = searchedGroups.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }

            switch changes {
            case .initial, .update(_, _, _, _):
                tableView.reloadData()
                
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
