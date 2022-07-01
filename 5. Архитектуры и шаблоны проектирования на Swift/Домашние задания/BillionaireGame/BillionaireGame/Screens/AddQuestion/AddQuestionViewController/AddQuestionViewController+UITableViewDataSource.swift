//
//  AddQuestionViewController+UITableViewDataSource.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import UIKit

//MARK: - UITableViewDataSource extension

extension AddQuestionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AddQuestionCell
        return cell
    }
}
