//
//  GlobalGroupsController+TableDataSource.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - Extension of GlobalGroupsController for UITableViewDataSource
extension GlobalGroupsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.allGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierGroupCell,
                                                       for: indexPath) as? GroupCell else { return UITableViewCell() }
        cell.configure(group: Storage.shared.allGroups[indexPath.row])
        return cell
    }
}
