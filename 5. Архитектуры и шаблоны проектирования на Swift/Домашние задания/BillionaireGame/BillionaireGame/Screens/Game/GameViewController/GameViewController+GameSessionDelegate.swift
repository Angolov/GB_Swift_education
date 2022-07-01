//
//  GameViewController+GameSessionDelegate.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import UIKit

//MARK: - GameSessionDelegate extension

extension GameViewController: GameSessionDelegate {
    
    func nextQuestion() {
        session.index.value += 1
        currentQuestion = session.questionStrategy.getQuestion(for: session)
        session.hintUsageFacade.currentQuestion = currentQuestion
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        let verdict = currentQuestion.checkAnswer(answer)
        if !verdict {
            session.index.value -= 1
        }
        return verdict
    }
}
