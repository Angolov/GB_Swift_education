//
//  FriendListController+UINavigationControllerDelegate.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 29.01.2022.
//

import UIKit

//MARK: - Extension of FriendListController for UINavigationControllerDelegate
extension FriendListController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push,
           toVC is FriendGalleryController {
            return PushAnimator()
        }
        return nil
    }
}
