//
//  RedLightState.swift
//  TrafficLight
//
//  Created by Антон Головатый on 19.06.2022.
//

import Foundation
import UIKit

// MARK: - RedLightState class declaration

final class RedLightState: TrafficLightState {
    
    private(set) var isCompleted: Bool = false
    
    weak var redView: UIView?
    weak var yellowView: UIView?
    weak var greenView: UIView?
    
    init(redView: UIView, yellowView: UIView, greenView: UIView) {
        self.redView = redView
        self.yellowView = yellowView
        self.greenView = greenView
    }
    
    func begin() {
        redView?.backgroundColor = .red
        yellowView?.backgroundColor = .darkGray
        greenView?.backgroundColor = .darkGray
    }
    
    func switchLight() {
        sleep(1)
        isCompleted = true
    }
}
