//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - Player enum declaration

public enum Player: CaseIterable {
    
    // MARK: - Cases
    
    case first
    case second
    case computer
    
    // MARK: - Properties
    
    var next: Player {
        switch self {
        case .first: return .second
        case .second, .computer: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first: return XView()
        case .second, .computer: return OView()
        }
    }
}
