//
//  UserGroupsController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import RealmSwift

//MARK: - UserGroupsController class declaration

final class UserGroupsController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    
    private let adapter = VKServicesAdapter()
    
    let fromUserGroupsToGlobalGroupList = "fromUserGroupsToGlobalGroupList"
    
    var userGroups = [Group]()
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GroupCell", bundle: nil),
                           forCellReuseIdentifier: GroupCell.reuseIdentifier)
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.title = "Изменить"
        
        guard let userID = Session.instance.userID else { return }
        
        adapter.getGroups(forUser: userID) { [weak self] groups in
            guard let strongSelf = self else { return }
            strongSelf.userGroups = groups
            strongSelf.tableView.reloadData()
        }
    }
}
