//
//  castomNavigationController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 04.11.2021.
//

import UIKit

final class CastomNavigationController: UINavigationController {
    let interactiveTransition = InteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

// MARK: = UINaviDelegat

extension CastomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactiveTransition.isStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        case .push:
            interactiveTransition.viewController = toVC
            return PushAnimator()
        default:
            return nil
        }
    }
}
