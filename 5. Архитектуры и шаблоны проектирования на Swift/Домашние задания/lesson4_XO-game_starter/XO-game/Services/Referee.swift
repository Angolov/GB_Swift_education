//
//  Referee.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - Referee class declaration

public final class Referee {
    
    // MARK: - Properties
    
    public let gameboard: Gameboard
    
    public private(set) lazy var winningCombinations: [[GameboardPosition]] = {
        var winningCombinations: [[GameboardPosition]] = []
        generateWinsByColumn(result: &winningCombinations)
        generateWinsByRow(result: &winningCombinations)
        generateWinLeftDiagonal(result: &winningCombinations)
        generateWinRightDiagonal(result: &winningCombinations)
        return winningCombinations
    }()
    
    // MARK: - Initializer
    
    public init(gameboard: Gameboard) {
        self.gameboard = gameboard
    }
    
    // MARK: - Public methods
    
    public func determineWinner() -> Player? {
        for player in Player.allCases {
            if doesPlayerHaveWinningCombination(player) {
                return player
            }
        }
        return nil
    }
    
    public func determineDraw() -> Bool {
        return !gameboard.hasEmptyPositions()
    }
    
    // MARK: - Private methods
    
    private func generateWinsByColumn(result: inout [[GameboardPosition]]) {
        var array: [GameboardPosition] = []
        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                array.append(GameboardPosition(column: column, row: row))
            }
            result.append(array)
            array = []
        }
    }
    
    private func generateWinsByRow(result: inout [[GameboardPosition]]) {
        var array: [GameboardPosition] = []
        for row in 0 ..< GameboardSize.rows {
            for column in 0 ..< GameboardSize.columns {
                array.append(GameboardPosition(column: column, row: row))
            }
            result.append(array)
            array = []
        }
    }
    
    private func generateWinLeftDiagonal(result: inout [[GameboardPosition]]) {
        guard GameboardSize.columns == GameboardSize.rows else { return }
        var array: [GameboardPosition] = []
        for i in 0 ..< GameboardSize.columns {
            array.append(GameboardPosition(column: i, row: i))
        }
        result.append(array)
    }
    
    private func generateWinRightDiagonal(result: inout [[GameboardPosition]]) {
        guard GameboardSize.columns == GameboardSize.rows else { return }
        var array: [GameboardPosition] = []
        for i in 0 ..< GameboardSize.rows {
            array.append(GameboardPosition(column: i, row: GameboardSize.rows - 1 - i))
        }
        result.append(array)
    }
    
    private func doesPlayerHaveWinningCombination(_ player: Player) -> Bool {
        for winningPositions in winningCombinations {
            if gameboard.contains(player: player, at: winningPositions) {
                return true
            }
        }
        return false
    }
}

