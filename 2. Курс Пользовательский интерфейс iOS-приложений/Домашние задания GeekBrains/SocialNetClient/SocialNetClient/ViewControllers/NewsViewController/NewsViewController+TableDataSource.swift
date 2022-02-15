//
//  NewsViewController+TableDataSource.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit

//MARK: - Extension of NewsViewController for UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier,
                                                       for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.frame.size.width = tableView.frame.width
        cell.configure(with: news[indexPath.row])
        
        return cell
    }
}
