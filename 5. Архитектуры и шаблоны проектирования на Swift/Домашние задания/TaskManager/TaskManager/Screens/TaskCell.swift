//
//  TaskCell.swift
//  TaskManager
//
//  Created by Антон Головатый on 19.06.2022.
//

import UIKit

// MARK: - TaskCell class declaration

final class TaskCell: UITableViewCell {
    
    // MARK: - UI elements
    
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        taskLabel.text = nil
        counterLabel.text = nil
    }
    
    override func layoutSubviews() {
        contentView.addSubview(taskLabel)
        contentView.addSubview(counterLabel)
        
        taskLabel.frame = CGRect(x: 10,
                                 y: 5,
                                 width: contentView.width * 2 / 3,
                                 height: 26)
        counterLabel.frame = CGRect(x: taskLabel.right + 5,
                                    y: taskLabel.top,
                                    width: contentView.width - taskLabel.width - 20,
                                    height: taskLabel.height)
    }
    
    func configure(with task: Task) {
        taskLabel.text = task.name
        counterLabel.text = "\(task.subtasks.count)"
    }
}
