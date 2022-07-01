//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 22.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchModuleBuilder {
    
    static func build() -> (UIViewController & SearchViewInput) {
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, router: router)
        let viewController = SearchViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
