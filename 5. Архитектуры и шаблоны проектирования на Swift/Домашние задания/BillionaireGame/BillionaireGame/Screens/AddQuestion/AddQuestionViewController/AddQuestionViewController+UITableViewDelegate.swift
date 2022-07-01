//
//  AddQuestionViewController+UITableViewDelegate.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import UIKit

//MARK: - UITableViewDelegate extension

extension AddQuestionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
