//
//  LogAction.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - LogAction enum declaration

public enum LogAction {
    
    // MARK: - Cases
    
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}

// MARK: - Log func declaration

public func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
