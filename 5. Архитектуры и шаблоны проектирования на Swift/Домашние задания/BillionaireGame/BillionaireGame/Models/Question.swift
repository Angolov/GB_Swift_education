//
//  Question.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 27.05.2022.
//

import Foundation

//MARK: - Question struct declaration

struct Question: Codable {
    
    //MARK: - Properties
    
    let question: String
    let answers: [String: Bool]
    
    private(set) var answersArray: [String]
    
    //MARK: - Initializer
    
    init(question: String, answersArray: [String], correctAnswer: String) {
        var answersDict: [String: Bool] = [:]
        for answer in answersArray {
            answersDict[answer] = false
        }
        answersDict[correctAnswer] = true
        
        self.question = question
        self.answersArray = answersArray
        self.answers = answersDict
    }
    
    //MARK: - Methods
    
    func checkAnswer(_ answer: String) -> Bool {
        guard let result = answers[answer] else { return false }
        return result
    }
    
    func friendHelp() -> String {
        
        var result = "Я думаю, правильный ответ: "
        let randomNumber = Int.random(in: 1...10)
        
        for answer in answersArray where answer.count > 1 {
            guard let answerIsCorrect = answers[answer] else { return "" }
            
            if randomNumber < 8,
               answerIsCorrect {
                result += answer
                break
            }
            else if randomNumber >= 8,
                    !answerIsCorrect {
                result += answer
                break
            }
        }
        return result
    }
    
    func viewersHelp() -> String {
        var counter = 100
        var viewersHelp: [(String, Int)] = []
        
        for answer in answersArray where answer.count > 1 {
            guard let answerIsCorrect = answers[answer] else { return "" }
            var percentage = Int.random(in: 0...12)
            
            if answerIsCorrect {
                percentage += 52
            }
            
            viewersHelp.append((answer, percentage))
            counter -= percentage
        }
        viewersHelp[Int.random(in: 0...viewersHelp.count - 1)].1 += counter
        
        var result = ""
        for viewersAnswerHelp in viewersHelp {
            result += "\n\(viewersAnswerHelp.0): \(viewersAnswerHelp.1)%"
        }
        return result
    }
    
    mutating func fiftyFiftyHelp() {
        var counter = 0
        
        for i in 0...answersArray.count where counter < 2 {
            if let answerIsCorrect = answers[answersArray[i]],
               !answerIsCorrect {
                answersArray[i] = ""
                counter += 1
            }
        }
    }
}
