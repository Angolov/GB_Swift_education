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
        return UIConstants.heightForGroupCellTableView
    }
}
