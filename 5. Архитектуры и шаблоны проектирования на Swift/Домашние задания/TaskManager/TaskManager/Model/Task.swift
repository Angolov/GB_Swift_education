//
//  Task.swift
//  TaskManager
//
//  Created by Антон Головатый on 19.06.2022.
//

import Foundation

// MARK: - Task class declaration

final class Task {
    
    // MARK: - Properties
    
    private(set) var name: String
    private(set) var subtasks: [Task] = []
    
    // MARK: - Initializer
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: - Public methods
    
    public func updateSubtasks(_ tasks: [Task]) {
        subtasks = tasks
    }
}
