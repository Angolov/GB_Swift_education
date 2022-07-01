//
//  NewsViewController+TableViewDelegate.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 24.05.2022.
//

import UIKit

//MARK: - Extension of NewsViewController for UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let newsItem = news[indexPath.section]
        var newsCellType = NewsCellType(rawValue: 0)
        if newsItem.photosNames.count == 0, indexPath.row > 0 {
            newsCellType = NewsCellType(rawValue: indexPath.row + 1)
        }
        else {
            newsCellType = NewsCellType(rawValue: indexPath.row)
        }
        
        switch newsCellType {
        case .photo:
            guard let url = URL(string: newsItem.photosNames[0]),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return UITableView.automaticDimension }
            let height = image.size.height
            let width = image.size.width
            let tableWidth = tableView.bounds.width
            let aspectRatio = height / width
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}
    
