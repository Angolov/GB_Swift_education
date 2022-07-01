//
//  GameViewController+UITableViewDelegate.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import UIKit

//MARK: - UITableViewDelegate extension

extension GameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnswer = currentQuestion.answersArray[indexPath.row]
        guard selectedAnswer.count > 1 else { return }
        let verdict = checkAnswer(selectedAnswer)
        
        if verdict {
            if session.index.value >= session.questionsCount - 1 {
                showAlertWith(title: "Поздравляем!", message: "Вы ответили на все вопросы.\nВы миллионер!")
            }
            else {
                nextQuestion()
                headerView.configure(currentSum: session.currentMoney,
                                     question: currentQuestion.question)
                tableView.reloadData()
            }
        }
        else {
            showAlertWith(title: "Вы проиграли(", message: "Ответ был неверный")
        }
    }
    
    private func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            Game.shared.gameEnded()
            strongSelf.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
}
