//
//  TaskListViewController.swift
//  TaskManager
//
//  Created by Антон Головатый on 19.06.2022.
//

import UIKit

// MARK: - TaskListViewController class declaration

final class TaskListViewController: UIViewController {
    
    // MARK: - UI elements
    
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    // MARK: - Properties
    
    var tasks: [Task] = []
    var completion: (([Task]) -> Void)?
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.registerCell(TaskCell.self)
        
        if let controllers = navigationController?.viewControllers,
           controllers.count > 1 {
            let previousControllerIndex = controllers.count - 2
            let title = controllers[previousControllerIndex].navigationItem.title ?? "Back"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< \(title)", style: .done, target: self, action: #selector(backButtonTapped))
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableview.frame = view.bounds
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "New task",
                                      message: "Enter new task name below",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] action in
            guard let text = alert.textFields?[0].text,
                  text.count > 0
            else { return }
            
            self?.tasks.append(Task(name: text))
            self?.tableview.reloadData()
        }))
        present(alert, animated: true)
    }
    
    @objc func backButtonTapped() {
        completion?(tasks)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource extension

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(forIndexPath: indexPath) as TaskCell
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate extension

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
        let vc = TaskListViewController()
        vc.navigationItem.title = selectedTask.name
        vc.tasks = selectedTask.subtasks
        vc.completion = { [weak self] tasks in
            guard let strongSelf = self else { return }
            strongSelf.tasks[indexPath.row].updateSubtasks(tasks)
            strongSelf.tableview.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
