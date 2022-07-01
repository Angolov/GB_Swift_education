//
//  BlindInputState.swift
//  XO-game
//
//  Created by Антон Головатый on 19.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - BlindInputState class declaration

public class BlindInputState: GameState {
    
    // MARK: - Properties
    
    public private(set) var isCompleted = false
    public let player: Player
    public let markViewPrototype: MarkView
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    private let gameMoves = GameMoves.shared
    private var counter = 1
    
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
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        default: break
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView,
              let gameboard = self.gameboard,
              gameboardView.canPlaceMarkView(at: position) else { return }
        
        let playerMove = PlayerMove(player: self.player,
                                    position: position,
                                    gameboard: gameboard,
                                    gameboardView: gameboardView)
        
        gameMoves.addMove(playerMove: playerMove)
        gameboardView.placeMarkView(player.markViewPrototype,
                                    at: position)
        counter += 1
        
        if counter > 5 {
            gameboardView.clear()
            self.isCompleted = true
        }
    }
}
