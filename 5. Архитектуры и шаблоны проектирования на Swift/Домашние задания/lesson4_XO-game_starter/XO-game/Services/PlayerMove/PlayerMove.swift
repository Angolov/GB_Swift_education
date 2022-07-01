//
//  PlayerMove.swift
//  XO-game
//
//  Created by Антон Головатый on 07.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation
import UIKit

// MARK: - PlayerMove class declaration

final class PlayerMove {
    
    // MARK: - Properties
    
    let player: Player
    let position: GameboardPosition
    
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardView?
    
    // MARK: - Initializer
    
    init(player: Player,
         position: GameboardPosition,
         gameboard: Gameboard,
         gameboardView: GameboardView) {
        
        self.player = player
        self.position = position
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    // MARK: - Methods
    
    public func execute() {
        gameboard?.setPlayer(player, at: position)
        gameboardView?.placeMarkView(player.markViewPrototype.copy(), at: position)
        Log(.playerInput(player: self.player, position: position))
    }
}
