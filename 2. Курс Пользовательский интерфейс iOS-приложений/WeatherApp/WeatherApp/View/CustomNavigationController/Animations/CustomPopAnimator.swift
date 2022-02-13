//
//  CustomPopAnimator.swift
//  WeatherApp
//
//  Created by Антон Головатый on 13.02.2022.
//

import UIKit

//MARK: - CustomPopAnimator class declaration
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.frame = source.view.frame
        
        let translation = CGAffineTransform(translationX: -200, y: 0)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        destination.view.transform = translation.concatenating(scale)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubicPaced) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                source.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4,
                               relativeDuration: 0.4) {
                source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25,
                               relativeDuration: 0.75) {
                destination.view.transform = .identity
            }
        } completion: { isSuccessfull in
            if isSuccessfull,
               !transitionContext.transitionWasCancelled {
                source.removeFromParent()
                transitionContext.completeTransition(true)
            } else {
                destination.view.transform = .identity
            }
        }

    }
}
