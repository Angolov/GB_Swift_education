//
//  +UITableViewCell.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import UIKit

//MARK: - Reusable protocol for Cell reuseID

protocol Reusable {}

extension Reusable where Self: UITableViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}

//MARK: - UITableViewCell extension for Reusable

extension UITableViewCell: Reusable {}
