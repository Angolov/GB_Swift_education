//
//  GameMoves.swift
//  XO-game
//
//  Created by Антон Головатый on 07.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - GameMoves class declaration

final class GameMoves {
    
    // MARK: - Singleton
    static let shared = GameMoves()
    private init() {}
    
    // MARK: - Properties
    
    public var isCompleted = false
    
    private var moves: [PlayerMove] = []
    private var firstPlayerMoves: [PlayerMove] = []
    private var secondPlayerMoves: [PlayerMove] = []
    
    // MARK: - Public methods
    
    public func addMove(player: Player,
                        position: GameboardPosition,
                        gameboard: Gameboard,
                        gameboardView: GameboardView) {
        
        let move = PlayerMove(player: player,
                              position: position,
                              gameboard: gameboard,
                              gameboardView: gameboardView)
        moves.append(move)
    }
    
    public func addMove(playerMove: PlayerMove) {
        
        switch playerMove.player {
        case .first:
            firstPlayerMoves.append(playerMove)
        case .second, .computer:
            secondPlayerMoves.append(playerMove)
        }
    }
    
    public func makeMoves() {
        isCompleted = false
        prepareMoves()
        var counter = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            
            strongSelf.moves[counter].execute()
            counter += 1
            
            if counter == strongSelf.moves.count {
                timer.invalidate()
                strongSelf.moves = []
                strongSelf.isCompleted = true
            }
        }
    }
    
    // MARK: - Private methods
    
    private func prepareMoves() {
        moves = firstPlayerMoves
        
        if moves.isEmpty {
            moves = secondPlayerMoves
        } else {
            for index in 0 ..< secondPlayerMoves.count {
                let secondPlayerMove = secondPlayerMoves[index]
                let insertIndex = index * 2 + 1
                moves.insert(secondPlayerMove, at: insertIndex)
            }
        }
        
        firstPlayerMoves = []
        secondPlayerMoves = []
    }
}
