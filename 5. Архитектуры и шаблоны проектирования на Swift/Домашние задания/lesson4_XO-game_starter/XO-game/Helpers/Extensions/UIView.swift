//
//  UIView.swift
//  XO-game
//
//  Created by Антон Головатый on 06.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIView extension for dimensions

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}
