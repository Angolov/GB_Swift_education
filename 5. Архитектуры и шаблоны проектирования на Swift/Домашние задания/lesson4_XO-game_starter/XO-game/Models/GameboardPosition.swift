//
//  GameBoardPosition.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - GameboardPosition struct declaration

public struct GameboardPosition: Hashable {
    
    // MARK: - Properties
    
    public let column: Int
    public let row: Int
}
