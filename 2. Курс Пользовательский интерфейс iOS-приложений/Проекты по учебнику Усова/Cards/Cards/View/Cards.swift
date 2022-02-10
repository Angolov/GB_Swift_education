//
//  Cards.swift
//  Cards
//
//  Created by Антон Головатый on 10.02.2022.
//

import UIKit

protocol FlippableView: UIView {
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? { get set }
    func flip()
}

class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    
    var color: UIColor!
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var flipCompletionHandler: ((FlippableView) -> Void)?
    var cornerRadius = 20
    
    private let margin: Int = 10
    private var anchorPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var startTouchPoint: CGPoint!
    
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: UIView = self.getBackSideView()
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
        setupBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)

        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    func flip() {
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.5,
                          options: [.transitionFlipFromTop],
                          completion: { _ in
            self.flipCompletionHandler?(self) })
        isFlipped = !isFlipped
    }
    
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        let shapeView = UIView(frame: CGRect(x: margin,
                                             y: margin,
                                             width: Int(self.bounds.width)-margin*2,
                                             height: Int(self.bounds.height)-margin*2))
        view.addSubview(shapeView)
        
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        switch ["circle", "line"].randomElement()! {
            
        case "circle":
            let layer = BackSideCircle(size: self.bounds.size,
                                       fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
            
        case "line":
            let layer = BackSideLine(size: self.bounds.size,
                                     fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
            
        default:
            break
        }
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: window) else { return }
        
        anchorPoint.x = touchLocation.x - frame.minX
        anchorPoint.y = touchLocation.y - frame.minY
        startTouchPoint = frame.origin
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: window) else { return }
        
        let newX = touchLocation.x - anchorPoint.x
        let newY = touchLocation.y - anchorPoint.y
        
        self.frame.origin.x = newX
        self.frame.origin.y = newY
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.frame.origin == startTouchPoint {
            flip()
        }
    }
}
