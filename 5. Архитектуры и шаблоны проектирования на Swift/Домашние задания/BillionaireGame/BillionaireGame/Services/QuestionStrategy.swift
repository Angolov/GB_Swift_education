//
//  QuestionStrategy.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 01.06.2022.
//

import Foundation

//MARK: QuestionStrategy protocol declaration

protocol QuestionStrategy: AnyObject {
    func getQuestion(for session: GameSession) -> Question
}

//MARK: SequentialQuestionStrategy class declaration

final class SequentialQuestionStrategy: QuestionStrategy {
    
    func getQuestion(for session: GameSession) -> Question {
        return session.questionsData[session.index.value]
    }
}

//MARK: RandomQuestionStrategy class declaration

final class RandomQuestionStrategy: QuestionStrategy {
    
    func getQuestion(for session: GameSession) -> Question {
        let index = Int.random(in: 0...session.questionsData.count - 1)
        return session.questionsData.remove(at: index)
    }
}

