//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Антон Головатый on 07.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ComputerInputState class declaration

public class ComputerInputState: GameState {
    
    // MARK: - Properties
    
    public private(set) var isCompleted = false
    public let player: Player
    public let markViewPrototype: MarkView
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    private let gameMoves = GameMoves.shared
    
    // MARK: - Initializer
    
    init(player: Player,
         markViewPrototype: MarkView,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    // MARK: - Public methods
    
    public func begin() {
        gameViewController?.secondPlayerTurnLabel.text = "Computer"
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        self.gameViewController?.winnerLabel.isHidden = true
        
        if let position = getPosition() {
            addMark(at: position)
        }
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView,
              let gameboard = self.gameboard,
              gameboardView.canPlaceMarkView(at: position) else { return }
        
        let computerMove = PlayerMove(player: self.player,
                                    position: position,
                                    gameboard: gameboard,
                                    gameboardView: gameboardView)
        
        gameMoves.addMove(playerMove: computerMove)
        gameMoves.makeMoves()
        
        self.isCompleted = true
    }
    
    private func getPosition() -> GameboardPosition? {
        guard let gameboard = gameboard else { return nil }

        let emptySpaces = gameboard.returnEmptyPositions()
        let randomIndex = Int.random(in: 0..<emptySpaces.count)
        return emptySpaces[randomIndex]
    }
}
