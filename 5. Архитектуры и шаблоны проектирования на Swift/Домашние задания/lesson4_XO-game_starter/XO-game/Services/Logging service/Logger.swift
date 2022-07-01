//
//  Logger.swift
//  XO-game
//
//  Created by Антон Головатый on 05.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

// MARK: - Logger class declaration

final class Logger {
    
    func writeMessageToLog(_ message: String) {
        /// Здесь должна быть реализация записи сообщения в лог.
        /// Для простоты примера паттерна не вдаемся в эту реализацию, а просто печатаем текст в консоль.
        print(message)
    }
}
