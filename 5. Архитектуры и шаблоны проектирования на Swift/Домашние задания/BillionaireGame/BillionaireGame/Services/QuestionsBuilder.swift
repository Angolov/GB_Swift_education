//
//  QuestionsBuilder.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import Foundation

//MARK: - QuestionsBuilder class declaration

final class QuestionsBuilder {
    
    //MARK: - Properties
    
    private var question = ""
    private var answersArray: [String] = []
    private var correctAnswer = ""
    
    private(set) var questions: [Question] = []
    
    //MARK: - Methods
    
    func build() -> [Question] {
        return questions
    }
    
    func addQuestion(question: String) {
        self.question = question
    }
    
    func addAnswers(answers: [String]) {
        self.answersArray = answers
    }
    
    func addCorrectAnswer(answer: String) {
        self.correctAnswer = answer
    }
    
    func addGameQuestion() {
        
        let gameQuestion = Question(question: question,
                                    answersArray: answersArray,
                                    correctAnswer: correctAnswer)
        
        self.questions.append(gameQuestion)
    }
}
