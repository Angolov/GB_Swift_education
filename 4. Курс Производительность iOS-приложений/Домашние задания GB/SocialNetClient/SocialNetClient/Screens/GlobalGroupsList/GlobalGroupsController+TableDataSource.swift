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
        return searchedGroups.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseIdentifier,
                                                       for: indexPath) as? GroupCell
        else { return UITableViewCell() }
        cell.configure(group: searchedGroups[indexPath.row])
        return cell
    }
}
