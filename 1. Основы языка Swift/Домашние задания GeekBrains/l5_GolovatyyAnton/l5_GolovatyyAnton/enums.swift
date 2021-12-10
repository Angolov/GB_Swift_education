//
//  enums.swift
//  l5_GolovatyyAnton
//
//  Created by Антон Головатый on 04.12.2021.
//

// MARK: - Enums
enum Engine {
    case on
    case off
}

enum Window {
    case opened
    case closed
}

enum Transmission {
    case AT
    case MT
}

enum Gear {
    case P
    case D
    case R
    case N
    case first
    case second
    case third
    case forth
    case fifth
    case sixth
}

enum Trunk {
    case load (with: Int)
    case unload (with: Int)
}
