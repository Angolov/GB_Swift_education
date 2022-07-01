//
//  ResultsViewController.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 27.05.2022.
//

import UIKit

//MARK: - ResultsViewController class declaration

final class ResultsViewController: UIViewController {

    //MARK: - UI elements
    
    lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Результаты"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    //MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(headerLabel)
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.registerCell(ResultsCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.frame = CGRect(x: 0,
                                   y: 0,
                                   width: self.view.width,
                                   height: 52)
        tableView.frame = CGRect(x: 0,
                                 y: headerLabel.bottom,
                                 width: self.view.width,
                                 height: self.view.height - headerLabel.height)
    }
}
