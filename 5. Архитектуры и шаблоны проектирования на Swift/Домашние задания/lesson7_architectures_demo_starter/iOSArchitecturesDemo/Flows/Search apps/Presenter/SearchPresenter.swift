//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 22.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: class {
    var searchResults: [ITunesApp] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: class {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
}

final class SearchPresenter {
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    let interactor: SearchInteractorInput
    let router: SearchRouterInput
    
    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func requestApps(with query: String) {
        self.interactor.requestApps(with: query) { [weak self] result in
            guard let self = self else { return }
                self.viewInput?.throbber(show: false)
                result
                    .withValue { apps in
                        guard !apps.isEmpty else {
                            self.viewInput?.showNoResults()
                            return
                        }
                        self.viewInput?.hideNoResults()
                        self.viewInput?.searchResults = apps
                    }
                    .withError {
                        self.viewInput?.showError(error: $0)
                    }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        self.viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestApps(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        self.router.openDetails(for: app)
    }
}
