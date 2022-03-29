//
//  CloudLoadingViewController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 16.02.2022.
//

import UIKit

//MARK: - CloudLoadingViewController class declaration
final class CloudLoadingViewController: UIViewController {

    //MARK: - UI elements
    lazy private var cloudView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let fromCloudLoadingViewToLogin = "fromCloudLoadingViewToLogin"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCloudAnimations()
    }
    
    //MARK: - Private methods
    private func setupView() {

        view.addSubview(cloudView)
        cloudView.center = view.center
    }
    
    private func startCloudAnimations() {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -100, y: 0))
        path.addQuadCurve(to: CGPoint(x: -80, y: -40), controlPoint: CGPoint(x: -110, y: -30))
        path.addQuadCurve(to: CGPoint(x: -40, y: -80), controlPoint: CGPoint(x: -80, y: -80))
        path.addQuadCurve(to: CGPoint(x: 20, y: -80), controlPoint: CGPoint(x: -10, y: -120))
        path.addQuadCurve(to: CGPoint(x: 60, y: -40), controlPoint: CGPoint(x: 60, y: -80))
        path.addQuadCurve(to: CGPoint(x: 90, y: 0), controlPoint: CGPoint(x: 100, y: -30))
        path.close()

        let layerAnimation = CAShapeLayer()
        layerAnimation.path = path.cgPath
        layerAnimation.strokeColor = UIColor.white.cgColor
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 6
        layerAnimation.lineCap = .round
        cloudView.layer.addSublayer(layerAnimation)

        let startLoadingViewStart = CABasicAnimation(keyPath: "strokeStart")
        startLoadingViewStart.fromValue = 0
        startLoadingViewStart.toValue = 2
        startLoadingViewStart.duration = 3
        startLoadingViewStart.fillMode = .both
        startLoadingViewStart.isRemovedOnCompletion = false
        startLoadingViewStart.beginTime = 1.5
        
        let startLoadingViewEnd = CABasicAnimation(keyPath: "strokeEnd")
        startLoadingViewEnd.fromValue = 0
        startLoadingViewEnd.toValue = 2
        startLoadingViewEnd.duration = 3
        startLoadingViewEnd.fillMode = .both
        startLoadingViewEnd.isRemovedOnCompletion = false
        layerAnimation.add(startLoadingViewEnd, forKey: nil)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3.1
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [startLoadingViewStart, startLoadingViewEnd]
        animationGroup.repeatCount = 3
        layerAnimation.add(animationGroup, forKey: nil)
        
        let repeatCount = Int(animationGroup.repeatCount)
        var duration = CFTimeInterval()
        for _ in 1..<repeatCount {
            duration += animationGroup.duration
        }
        
        UIView.animate(withDuration: duration) {
            self.view.alpha = 0.99
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromCloudLoadingViewToLogin,
                               sender: nil)
        }

    }
}
