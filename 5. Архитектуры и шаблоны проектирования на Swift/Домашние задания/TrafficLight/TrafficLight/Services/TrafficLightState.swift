//
//  TrafficLightState.swift
//  TrafficLight
//
//  Created by Антон Головатый on 19.06.2022.
//

import Foundation

// MARK: - TrafficLightState protocol declaration

public protocol TrafficLightState {
    
    var isCompleted: Bool { get }
    
    func begin()
    func switchLight()
}
