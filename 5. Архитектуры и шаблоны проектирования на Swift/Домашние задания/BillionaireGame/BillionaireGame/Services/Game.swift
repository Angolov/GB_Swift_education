//
//  Game.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 27.05.2022.
//

import Foundation

//MARK: - Game class declaration

final class Game {
    
    //MARK: - Type property
    
    public static let shared = Game()
    
    //MARK: - Properties
    
    private let questionsCaretacker = QuestionsCaretacker()
    private let resultsCaretacker = ResultsCaretacker()
    private(set) var results: [Results] = [] {
        didSet {
            resultsCaretacker.save(results: results)
        }
    }
    public var gameSession: GameSession?
    public var questionSettings: QuestionSettings = .sequential
    
    //MARK: - Initializer
    
    private init() {
        results = resultsCaretacker.retrieveResults()
    }
    
    //MARK: - Methods
    
    func gameEnded() {
        guard let gameSession = gameSession else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "RU")
        
        let percentage: Double = Double(gameSession.index.value + 1) / Double(gameSession.questionsCount) * 100
        let currentDate = dateFormatter.string(from: Date())
        
        let gameResult = Results(date: currentDate, percentage: percentage, money: gameSession.currentMoney)
        results.append(gameResult)
        
        self.gameSession = nil
    }
    
    func addUserQuestions(_ questions: [Question]) {
        questionsCaretacker.save(questions: questions)
    }
    
    func retrieveUsersQuestions() -> [Question] {
        return questionsCaretacker.retrieveQuestions()
    }
}
