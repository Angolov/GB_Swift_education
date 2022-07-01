//
//  LogCommand.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - LogCommand class declaration

final class LogCommand {
    
    // MARK: - Properties
    
    let action: LogAction
    
    var logMessage: String {
        switch self.action {
        case .playerInput(let player, let position):
            return "\(player) placed mark at \(position)"
            
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) win game"
            } else {
                return "game finished with no winner"
            }
            
        case .restartGame:
            return "game restarted" }
    }
    
    // MARK: - Initializer
    
    init(action: LogAction) {
        self.action = action
    }
}
