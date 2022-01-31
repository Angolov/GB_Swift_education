//
//  GlobalGroupsController+TableDelegate.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of GlobalGroupsController for UITableViewDelegate
extension GlobalGroupsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForGroupCellTableView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedGroup = Storage.shared.allGroups[indexPath.row]
        doAfterGroupSelected?(selectedGroup)
        navigationController?.popViewController(animated: true)
    }
}
