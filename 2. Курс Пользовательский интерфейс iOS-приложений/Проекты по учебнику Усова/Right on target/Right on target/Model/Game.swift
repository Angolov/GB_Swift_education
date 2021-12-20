//
//  Game.swift
//  Right on target
//
//  Created by Антон Головатый on 18.12.2021.
//

//MARK: - GameProtocol declaration
protocol GameProtocol {
    associatedtype SecretType
    
    var score: Int { get }
    var isGameEnded: Bool { get }
    var currentSecretValue: SecretType { get set }
    
    func restartGame()
    func startNewRound()
    func calculateScore(with value: SecretType)
}

//MARK: - Game class declaration
final class Game<T: SecretValueProtocol>: GameProtocol {
    
    //MARK: - Private properties
    private var roundsCount: Int
    
    //MARK: - Public properties
    var score: Int
    var currentRound: Int
    var currentSecretValue: T
    var compareClosure: (T, T) -> Int
    
    //MARK: - Computed properties
    var isGameEnded: Bool {
        if roundsCount == currentRound {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Initializer
    init(secretValue: T,
         rounds: Int,
         compareClosure: @escaping (T, T) -> Int) {
        
        score = 0
        currentRound = 0
        roundsCount = rounds
        currentSecretValue = secretValue
        self.compareClosure = compareClosure
        
        startNewRound()
    }

    //MARK: - Public methods
    func restartGame() {
        
        score = 0
        currentRound = 0
        startNewRound()
    }
    
    func startNewRound() {
        
        currentRound += 1
        currentSecretValue.setRandomValue()
    }
    
    func calculateScore(with value: T) {
        
        score += compareClosure(currentSecretValue, value)
    }
}
