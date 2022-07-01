//
//  GameState.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - GameState protocol declaration

public protocol GameState {
    
    var isCompleted: Bool { get }
    
    func begin()
    func addMark(at position: GameboardPosition)
}
