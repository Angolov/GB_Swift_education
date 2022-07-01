//
//  SongSearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Alamofire

protocol SongSearchInteractorInput {
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

final class SongSearchInteractor: SongSearchInteractorInput {
    private let searchService = ITunesSearchService()
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        self.searchService.getSongs(forQuery: query, completion: completion)
    }
}
