//
//  SongSearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SongSearchRouterInput {
    func openPlayerForSong(from songs: [ITunesSong], atIndex index: Int)
}

final class SongSearchRouter: SongSearchRouterInput {
    weak var viewController: UIViewController?
    
    func openPlayerForSong(from songs: [ITunesSong], atIndex index: Int) {
        let vc = PlayerBuilderModule.build(withSongs: songs, andIndex: index)
        viewController?.present(vc, animated: true)
    }
}

