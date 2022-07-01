//
//  NewsViewController+TableViewDataSourcePrefetching.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 24.05.2022.
//

import UIKit

//MARK: - Extension of NewsViewController for UITableViewDataSourcePrefetching

extension NewsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > news.count - 5, !isLoading {
            
            isLoading = true
            
            services.fetchNewsData(startFrom: nextFrom) { [weak self] news, nextFrom in
                guard let strongSelf = self else { return }
                
                let indexSet = IndexSet(integersIn: strongSelf.news.count ..< (strongSelf.news.count + news.count))
                strongSelf.news.append(contentsOf: news)
                strongSelf.tableView.insertSections(indexSet, with: .automatic)
                strongSelf.isLoading = false
                strongSelf.nextFrom = nextFrom
            }
        }
    }
}
