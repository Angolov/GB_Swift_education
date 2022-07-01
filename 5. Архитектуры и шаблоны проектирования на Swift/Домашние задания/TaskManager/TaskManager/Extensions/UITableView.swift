//
//  +UITableView.swift
//  TaskManager
//
//  Created by Антон Головатый on 19.06.2022.
//

import UIKit

//MARK: - UITableView extension for Cell register and dequeue

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseID)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as? Cell
        else {
            fatalError("Fatal error for cell at \(indexPath)")
        }
        return cell
    }
}
