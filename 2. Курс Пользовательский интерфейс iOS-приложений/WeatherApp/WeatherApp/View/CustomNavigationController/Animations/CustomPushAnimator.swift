//
//  CustomPushAnimator.swift
//  WeatherApp
//
//  Created by Антон Головатый on 13.02.2022.
//

import UIKit

//MARK: - CustomPushAnimator class declaration
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubicPaced) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.75) {
                let translation = CGAffineTransform(translationX: -200, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2,
                               relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                destination.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.4) {
                destination.view.transform = .identity
            }
        } completion: { isSuccessfull in
            if isSuccessfull,
               !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
                transitionContext.completeTransition(true)
            }
        }

    }
}
