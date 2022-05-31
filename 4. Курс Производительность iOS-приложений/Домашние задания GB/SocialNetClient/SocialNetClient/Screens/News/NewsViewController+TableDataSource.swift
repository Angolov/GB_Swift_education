//
//  NewsViewController+TableDataSource.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit

//MARK: - Extension of NewsViewController for UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news[section].photosNames.count == 0 {
            return NewsCellType.allCases.count - 1
        }
        else {
            return NewsCellType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsItem = news[indexPath.section]
        var newsCellType = NewsCellType(rawValue: 0)
        
        if newsItem.photosNames.count == 0, indexPath.row > 0 {
            newsCellType = NewsCellType(rawValue: indexPath.row + 1)
        }
        else {
            newsCellType = NewsCellType(rawValue: indexPath.row)
        }

        switch newsCellType {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseIdentifier,
                                                           for: indexPath) as? NewsHeaderCell
            else { return UITableViewCell() }
            cell.configure(with: newsItem)
            return cell

        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseIdentifier,
                                                           for: indexPath) as? NewsPhotoCell
            else { return UITableViewCell() }
            cell.frame.size.width = tableView.frame.width
            cell.configure(with: newsItem.photosNames[0])
            return cell

        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsPostCell.reuseIdentifier,
                                                           for: indexPath) as? NewsPostCell
            else { return UITableViewCell() }
            cell.configure(with: newsItem)
            cell.seeMoreDidTapHandler = { [weak self] in
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
            return cell

        case .footer:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseIdentifier,
                                                           for: indexPath) as? NewsFooterCell
            else { return UITableViewCell() }
            cell.configure(with: newsItem)
            return cell

        default:
            return UITableViewCell()
        }
    }
}
