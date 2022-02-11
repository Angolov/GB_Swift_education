//
//  PushAnimator.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 04.11.2021.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration : TimeInterval = 0.5
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourse = transitionContext.viewController(forKey: .from) else {return}
        guard let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        sourse.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        sourse.view.frame = transitionContext.containerView.frame
        
        UIView.animate(withDuration: duration,
                       animations: {
            sourse.view.transform = CGAffineTransform(rotationAngle: .pi/2)
            destination.view.transform = .identity
        },
                       completion: { isCompleted in
            if isCompleted && !transitionContext.transitionWasCancelled {
            }else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(isCompleted && !transitionContext.transitionWasCancelled)
            destination.view.isHidden = false
        })
    }
}
