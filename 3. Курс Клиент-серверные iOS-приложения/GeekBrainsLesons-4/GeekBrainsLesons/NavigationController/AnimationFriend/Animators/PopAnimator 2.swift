//
//  PopAnimator.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 04.11.2021.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration : TimeInterval = 0.5
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourse = transitionContext.viewController(forKey: .from) else {return}
        guard let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: destination.view)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0), forView: sourse.view)
        sourse.view.frame = transitionContext.containerView.frame
        
        UIView.animate(withDuration: duration,
                       animations: {
            sourse.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
            destination.view.transform = .identity
        },
                       completion: { isCompleted in
            if isCompleted && !transitionContext.transitionWasCancelled {
                sourse.removeFromParent()
            }else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(isCompleted && !transitionContext.transitionWasCancelled)
            destination.view.isHidden = false
        })
    }
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
}
