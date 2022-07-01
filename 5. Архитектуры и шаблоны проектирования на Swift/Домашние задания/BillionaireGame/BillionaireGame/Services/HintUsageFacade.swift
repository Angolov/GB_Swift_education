//
//  HintUsageFacade.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 03.06.2022.
//

import Foundation

//MARK: - HintUsageFacade class declaration

final class HintUsageFacade {
    
    //MARK: - Property
    
    var currentQuestion: Question
    
    //MARK: - Initializer
    
    init(question: Question) {
        currentQuestion = question
    }
    
    //MARK: - Methods
    
    func callFriend() -> String {
        return currentQuestion.friendHelp()
    }
    
    func useAuditoryHelp() -> String {
        return currentQuestion.viewersHelp()
    }
    
    func use50to50Hint() -> Question {
        currentQuestion.fiftyFiftyHelp()
        return currentQuestion
    }
}
