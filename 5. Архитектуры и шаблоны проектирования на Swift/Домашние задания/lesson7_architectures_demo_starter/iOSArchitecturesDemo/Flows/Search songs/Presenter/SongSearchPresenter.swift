//
//  SongSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SongSearchViewInput: class {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SongSearchViewOutput: class {
    func viewDidSearch(with query: String)
    func viewDidSelectSong(from songs: [ITunesSong], atIndex index: Int)
}

final class SongSearchPresenter {
    
    weak var viewInput: (UIViewController & SongSearchViewInput)?
    let interactor: SongSearchInteractorInput
    let router: SongSearchRouterInput
    
    init(interactor: SongSearchInteractorInput, router: SongSearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func requestSongs(with query: String) {
        self.interactor.requestSongs(with: query) { [weak self] result in
        guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
}

// MARK: - SearchViewOutput

extension SongSearchPresenter: SongSearchViewOutput {
    
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestSongs(with: query)
    }
    
    func viewDidSelectSong(from songs: [ITunesSong], atIndex index: Int) {
        self.router.openPlayerForSong(from: songs, atIndex: index)
    }
}
