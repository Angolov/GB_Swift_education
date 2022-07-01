//
//  UserGroupsController+TableDelegate.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of UserGroupsController for UITableViewDelegate

extension UserGroupsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.heightForGroupCellTableView
    }
    
    func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDeleteSwipeInstance = UIContextualAction(style: .destructive,
                                                           title: "Удалить") { [weak self] _,_,_ in
            guard let self = self else { return }
            self.userGroups.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let actionsConfiguration = UISwipeActionsConfiguration(actions: [actionDeleteSwipeInstance])
        return actionsConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
