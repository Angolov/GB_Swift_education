//
//  ViewController.swift
//  TrafficLight
//
//  Created by Антон Головатый on 19.06.2022.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - UI elements
    
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    lazy var yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK: - Properties
    private var currentState: TrafficLightState! {
        didSet {
            currentState.begin()
        }
    }
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        view.addSubview(yellowView)
        view.addSubview(greenView)
        
        goToFirstState()
    }
    
    override func viewDidLayoutSubviews() {
        let size = view.width > view.height ? view.height / 4 : view.width / 4
        
        redView.frame = CGRect(x: view.center.x - size / 2,
                               y: view.center.y - size * 1.5,
                               width: size,
                               height: size)
        yellowView.frame = CGRect(x: redView.left,
                                  y: redView.bottom + 5,
                                  width: size,
                                  height: size)
        greenView.frame = CGRect(x: yellowView.left,
                                 y: yellowView.bottom + 5,
                                 width: size,
                                 height: size)
        
        redView.layer.cornerRadius = size / 2
        yellowView.layer.cornerRadius = size / 2
        greenView.layer.cornerRadius = size / 2
        
    }
    
    // MARK: - Private methods
    
    private func goToFirstState() {
        currentState = RedLightState(redView: redView,
                                     yellowView: yellowView,
                                     greenView: greenView)
        goToNextState()
    }
    
    private func goToNextState() {
        
        let interval = TimeInterval(1)
        
        Timer.scheduledTimer(withTimeInterval: interval,
                             repeats: true,
                             block: { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if strongSelf.currentState is RedLightState {
                strongSelf.currentState = GreenLightState(redView: strongSelf.redView,
                                                          yellowView: strongSelf.yellowView,
                                                          greenView: strongSelf.greenView)
                
            } else if strongSelf.currentState is YellowLightState {
                strongSelf.currentState = RedLightState(redView: strongSelf.redView,
                                                        yellowView: strongSelf.yellowView,
                                                        greenView: strongSelf.greenView)
                
            } else if strongSelf.currentState is GreenLightState {
                strongSelf.currentState = YellowLightState(redView: strongSelf.redView,
                                                           yellowView: strongSelf.yellowView,
                                                           greenView: strongSelf.greenView)
                
            }
        })
    }
}

