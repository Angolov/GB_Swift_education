//
//  UserGroupsController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - UserGroupsController class declaration
final class UserGroupsController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    let reuseIdentifierGroupCell = "reuseIdentifierGroupCell"
    let fromUserGroupsToGlobalGroupList = "fromUserGroupsToGlobalGroupList"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GroupCell", bundle: nil),
                           forCellReuseIdentifier: reuseIdentifierGroupCell)
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.title = "Изменить"
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == fromUserGroupsToGlobalGroupList {
            
            let destination = segue.destination as! GlobalGroupsController
            destination.doAfterGroupSelected = { [unowned self] selectedGroup in
                
                let contains = Storage.shared.userGroups.contains { _ in
                    for group in Storage.shared.userGroups {
                        if group.name == selectedGroup.name {
                            return true
                        }
                    }
                    return false
                }
                
                if !contains {
                    Storage.shared.userGroups.append(selectedGroup)
                }
                
                tableView.reloadData()
            }
        }
    }
}
