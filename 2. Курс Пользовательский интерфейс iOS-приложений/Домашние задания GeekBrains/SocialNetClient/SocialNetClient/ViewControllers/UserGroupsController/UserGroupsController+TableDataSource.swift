//
//  UserGroupsController+TableDataSource.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of UserGroupsController for UITableViewDataSource
extension UserGroupsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.userGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierGroupCell,
                                                       for: indexPath) as? GroupCell else { return UITableViewCell() }
        cell.configure(group: Storage.shared.userGroups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        
        let movedGroup = Storage.shared.userGroups[sourceIndexPath.row]
        Storage.shared.userGroups.remove(at: sourceIndexPath.row)
        Storage.shared.userGroups.insert(movedGroup, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    //MARK: - Corrections for editButtonItem name
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        
        if (self.isEditing) {
            self.editButtonItem.title = "Готово"
            
        } else {
            self.editButtonItem.title = "Изменить"
        }
    }
    
}
