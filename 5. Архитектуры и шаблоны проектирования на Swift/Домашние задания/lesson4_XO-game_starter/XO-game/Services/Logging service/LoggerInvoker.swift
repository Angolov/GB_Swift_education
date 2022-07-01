//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - LoggerInvoker class declaration

internal final class LoggerInvoker {
    
    // MARK: - Type property
    
    internal static let shared = LoggerInvoker()
    
    // MARK: - Properties
    
    private let logger = Logger()
    private let batchSize = 10
    private var commands: [LogCommand] = []
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Internal methods
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    // MARK: - Private methods
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else {
            return
        }
        self.commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        self.commands = []
    }
}
