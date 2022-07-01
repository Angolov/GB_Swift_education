//
//  ResultsViewController+UITableViewDataSource.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 31.05.2022.
//

import UIKit

//MARK: - UITableViewDataSource extension

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentResult = Game.shared.results[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ResultsCell
        cell.configure(with: currentResult)
        return cell
    }
}
