//
//  MovesExecutionState.swift
//  XO-game
//
//  Created by Антон Головатый on 19.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - MovesExecutionState class declaration

final class MovesExecutionState: GameState {
    
    private(set) var isCompleted: Bool = false
    private(set) weak var gameViewController: GameViewController?
    private let gameMoves = GameMoves.shared
    
    // MARK: - Initializer
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    // MARK: Public methods
    
    public func begin() {
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        
        gameMoves.makeMoves()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            if strongSelf.gameMoves.isCompleted {
                strongSelf.isCompleted = true
                timer.invalidate()
            }
        }
    }
    
    func addMark(at position: GameboardPosition) {}
}
