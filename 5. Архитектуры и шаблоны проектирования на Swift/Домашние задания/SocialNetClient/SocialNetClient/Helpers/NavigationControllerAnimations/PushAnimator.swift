//
//  Animator.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 29.01.2022.
//

import UIKit

//MARK: - PushAnimator class declaration

final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        let containerFrame = transitionContext.containerView.frame
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = CGRect(x: source.view.frame.width / 2,
                                        y: -source.view.frame.height / 2,
                                        width: source.view.frame.width,
                                        height: source.view.frame.height)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
      
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            destination.view.transform = .identity
            destination.view.frame = containerFrame
        } completion: { isSuccess in
            if isSuccess {
                transitionContext.completeTransition(isSuccess)
            }
        }
    }
}
