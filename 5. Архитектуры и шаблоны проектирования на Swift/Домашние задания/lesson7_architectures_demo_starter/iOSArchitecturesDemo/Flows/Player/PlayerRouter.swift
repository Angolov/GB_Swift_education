//
//  PlayerRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol PlayerRouterInput {
    func closePlayer()
}

final class PlayerRouter: PlayerRouterInput {
    
    weak var viewController: UIViewController?
    
    func closePlayer() {
        viewController?.dismiss(animated: true)
    }
}
