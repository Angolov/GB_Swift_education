//
//  GreenLightState.swift
//  TrafficLight
//
//  Created by Антон Головатый on 19.06.2022.
//

import Foundation
import UIKit

// MARK: - GreenLightState class declaration

final class GreenLightState: TrafficLightState {
    
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
        redView?.backgroundColor = .darkGray
        yellowView?.backgroundColor = .darkGray
        greenView?.backgroundColor = .green
    }
    
    func switchLight() {
        sleep(1)
        isCompleted = true
    }
}
