//
//  Card.swift
//  Cards
//
//  Created by Антон Головатый on 10.02.2022.
//

import UIKit

enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
    case emptyCircle
}

enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

typealias Card = (type: CardType, color: CardColor)
