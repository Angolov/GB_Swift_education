//
//  NewsViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class NewsViewController: UITableViewController {
    
    let news = NewsArray.iNeedNews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // динамический размер ячеек
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        // убираем дырень между ячейками
        tableView.sectionHeaderTopPadding = 0
        // перезагружаем
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellMain", for: indexPath) as? NewsMainViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: news[indexPath.section])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        header.backgroundColor = .gray
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5.0
    }
}
