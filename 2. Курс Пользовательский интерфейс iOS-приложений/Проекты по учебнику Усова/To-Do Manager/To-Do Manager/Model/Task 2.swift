//
//  Task.swift
//  To-Do Manager
//
//  Created by Антон Головатый on 25.12.2021.
//

//MARK: - Task enums
enum TaskPriority {
    case normal
    case important
}

enum TaskStatus: Int {
    case planned
    case completed
}

//MARK: - TaskProtocol declaration
protocol TaskProtocol {
    
    var title: String { get set }
    var type: TaskPriority { get set }
    var status: TaskStatus { get set }
}

//MARK: - Task struct declaration
struct Task: TaskProtocol {
    
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}
