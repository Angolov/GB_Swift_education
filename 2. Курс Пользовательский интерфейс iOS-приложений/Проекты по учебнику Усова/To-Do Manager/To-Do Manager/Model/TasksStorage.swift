//
//  TasksStorage.swift
//  To-Do Manager
//
//  Created by Антон Головатый on 25.12.2021.
//

import Foundation

//MARK: - TasksStorageProtocol declaration
protocol TasksStorageProtocol {
    
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

//MARK: - TasksStorage declaration
class TasksStorage: TasksStorageProtocol {
    
    private var storage = UserDefaults.standard
    var storageKey: String = "tasks"
    
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    
    func loadTasks() -> [TaskProtocol] {
        
//        let testTasks: [TaskProtocol] = [
//            Task(title: "Купить хлеб", type: .normal, status: .planned),
//            Task(title: "Помыть кота", type: .important, status: .planned),
//            Task(title: "Отдать долг Арнольду", type: .important, status: .completed),
//            Task(title: "Купить новый пылесос", type: .normal, status: .completed),
//            Task(title: "Подарить цветы супруге", type: .important, status: .planned),
//            Task(title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса", type: .important, status: .planned),
//            Task(title: "Позвонить родителям", type: .important, status: .planned)]
//
//        return testTasks
        
        var resultTasks: [TaskProtocol] = []
        let tasksFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []

        for task in tasksFromStorage {

            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else { continue }

            let type: TaskPriority = typeRaw == "important" ? .important : .normal
            let status: TaskStatus = statusRaw == "planned" ? .planned : .completed

            resultTasks.append(Task(title: title, type: type, status: status))
        }

        return resultTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        
        var arrayForStorage: [[String:String]] = []
        
        tasks.forEach { task in
            
            var newElementForStorage: Dictionary<String, String> = [:]
            
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.type.rawValue] = (task.type == .important) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            
            arrayForStorage.append(newElementForStorage)
        }
        
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
