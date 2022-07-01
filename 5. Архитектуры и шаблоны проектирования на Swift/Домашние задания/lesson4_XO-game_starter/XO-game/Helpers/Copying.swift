//
//  Copying.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

// MARK: - Copying protocol declaration

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self) }
}
