//
//  UserGroupsController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import RealmSwift
import PromiseKit

//MARK: - UserGroupsController class declaration
final class UserGroupsController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    private let services = VKServices()
    
    let fromUserGroupsToGlobalGroupList = "fromUserGroupsToGlobalGroupList"
    
    var userGroups = List<VKUserGroup>()
    var token: NotificationToken?
    
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
        
//        services.fetchVKData(ofType: .groups, withUserId: userID)
//        pairTableViewAndRealm()
        
        promisesHW(userID)
    }
    
    //MARK: - Private methods
    private func promisesHW(_ userID: String) {
     
        let promisesFunctions = GroupsVKRequestPromises()

        firstly {
            promisesFunctions.getUserGroups(for: userID)
        }.then { data in
            promisesFunctions.parseGroupsData(data)
        }.done { groups in
            promisesFunctions.saveGroupsData(groups)
            self.pairTableViewAndRealm()
        }.catch { error in
            print("Error")
        }
    }
    
    private func pairTableViewAndRealm() {
        guard let realm = try? Realm(),
              let vkUser = realm.object(ofType: VKUser.self, forPrimaryKey: Session.instance.userID)
        else { return }
        userGroups = vkUser.groups
        
        token = userGroups.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }

            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromUserGroupsToGlobalGroupList {
            let destination = segue.destination as! GlobalGroupsController
            destination.doAfterGroupSelected = { [unowned self] selectedGroup in
                
//                let contains = Storage.shared.userGroups.contains { _ in
//                    for group in Storage.shared.userGroups {
//                        if group.name == selectedGroup.name {
//                            return true
//                        }
//                    }
//                    return false
//                }
//
//                if !contains {
//                    Storage.shared.userGroups.append(selectedGroup)
//                }
//
//                tableView.reloadData()
            }
        }
    }
}
