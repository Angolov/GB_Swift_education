//
//  GameEndedState.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - GameEndedState class declaration

public class GameEndedState: GameState {
    
    // MARK: - Properties
    
    public let isCompleted = false
    public let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    // MARK: - Initializer
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    // MARK: Public methods
    
    public func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " wins"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        Log(.gameFinished(winner: self.winner))
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    // MARK: - Private methods
    
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        case .computer: return "Computer"
        }
    }
}
