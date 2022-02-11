//
//  GradientView.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 18.12.2021.
//

import UIKit

class GradientView: UIView {

	var startColor: UIColor = .white {
		didSet {
			updateColor()
		}
	}

	var endColor: UIColor = .white {
		didSet {
			updateColor()
		}
	}

	var startLocation: CGFloat = 0 {
		didSet {
			updateLocation()
		}
	}

	var endLocation: CGFloat = 1 {
		didSet {
			updateLocation()
		}
	}

	var startPoint: CGPoint = .zero {
		didSet {
			updateStartPoint()
		}
	}

	var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
		didSet {
			updateEndPoint()
		}
	}

	override static var layerClass: AnyClass {
		return CAGradientLayer.self
	}

	var gradientLayer: CAGradientLayer {
		return self.layer as! CAGradientLayer
	}


	func updateColor() {
		self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
	}

	func updateLocation() {
		self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
	}

	func updateStartPoint() {
		self.gradientLayer.startPoint = self.startPoint
	}

	func updateEndPoint() {
		self.gradientLayer.endPoint = self.endPoint
	}
}
