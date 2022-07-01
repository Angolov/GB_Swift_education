//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Alamofire

protocol SearchInteractorInput {
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
}

final class SearchInteractor: SearchInteractorInput {
    private let searchService = ITunesSearchService()
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        self.searchService.getApps(forQuery: query, then: completion)
    }
}
