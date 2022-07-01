//
//  PlayerBuilderModule.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class PlayerBuilderModule {
    
    static func build(withSongs songs: [ITunesSong], andIndex index: Int) -> (UIViewController & PlayerViewInput) {
        let router = PlayerRouter()
        let interactor = PlayerInteractor()
        let presenter = PlayerPresenter(songs: songs, index: index, router: router, interactor: interactor)
        let viewController = PlayerViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
