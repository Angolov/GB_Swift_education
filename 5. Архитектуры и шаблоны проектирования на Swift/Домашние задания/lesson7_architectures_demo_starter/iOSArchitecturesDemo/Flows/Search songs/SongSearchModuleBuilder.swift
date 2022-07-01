//
//  SongSearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongSearchModuleBuilder {
    
    static func build() -> (UIViewController & SongSearchViewInput) {
        let interactor = SongSearchInteractor()
        let router = SongSearchRouter()
        let presenter = SongSearchPresenter(interactor: interactor, router: router)
        let viewController = SongSearchViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
