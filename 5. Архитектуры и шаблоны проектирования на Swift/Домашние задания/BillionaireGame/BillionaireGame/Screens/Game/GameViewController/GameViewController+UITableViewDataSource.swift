//
//  GameViewController+UITableViewDataSource.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import UIKit

//MARK: - UITableViewDataSource extension

extension GameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion.answersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AnswerCell
        cell.configure(withLiteral: charIndex[indexPath.row],
                       andAnswer: currentQuestion.answersArray[indexPath.row])
        return cell
    }
}
