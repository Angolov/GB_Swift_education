//
//  NewsViewController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit
import RealmSwift

//MARK: - NewsViewController class declaration

final class NewsViewController: UIViewController {
    
    //MARK: - NewsCellType enum declaration
    
    enum NewsCellType: Int, CaseIterable {
        case header = 0
        case photo
        case text
        case footer
    }
    
    //MARK: - UI elements
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    //MARK: - Properties
    
    let services = VKServicesProxy(vkService: VKServices())
    var news = [VKUserNews]()
    var nextFrom = ""
    var isLoading = false
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRefreshControl()
        
        services.fetchNewsData { [weak self] fetchedNews, nextFrom in
            guard let strongSelf = self else { return }
            strongSelf.news = fetchedNews
            strongSelf.tableView.reloadData()
            strongSelf.nextFrom = nextFrom
        }
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        tableView.frame = self.view.bounds
        
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(NewsHeaderCell.self, forCellReuseIdentifier: NewsHeaderCell.reuseIdentifier)
        tableView.register(NewsPhotoCell.self, forCellReuseIdentifier: NewsPhotoCell.reuseIdentifier)
        tableView.register(NewsPostCell.self, forCellReuseIdentifier: NewsPostCell.reuseIdentifier)
        tableView.register(NewsFooterCell.self, forCellReuseIdentifier: NewsFooterCell.reuseIdentifier)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating...")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshNews() {
        tableView.refreshControl?.beginRefreshing()
        
        let mostFreshNewsDate = news.first?.date.timeIntervalSince1970 ?? Date().timeIntervalSince1970
        services.fetchNewsData(startTime: mostFreshNewsDate + 1) { [weak self] news, nextFrom in
            guard let strongSelf = self else { return }
            strongSelf.tableView.refreshControl?.endRefreshing()
            strongSelf.nextFrom = nextFrom
            
            guard news.count > 0 else { return }
            strongSelf.news = news + strongSelf.news
            let indexSet = IndexSet(integersIn: 0..<news.count)
            strongSelf.tableView.insertSections(indexSet, with: .automatic)
        }
    }
}
