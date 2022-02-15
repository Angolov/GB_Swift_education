//
//  NewsViewController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit

//MARK: - NewsViewController class declaration
final class NewsViewController: UIViewController {
    
    //MARK: - UI elements
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.allowsSelection = false
        //tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    //MARK: - Public properties
    var news: [NewsProtocol] = Storage.shared.news
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
//        for news in news {
//            print(news)
//            print("=============")
//        }
    }
    
    //MARK: - Private methods
    private func setupView() {
        tableView.frame = self.view.bounds
        
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }
}
