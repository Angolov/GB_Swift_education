//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
        let testView = TestView(frame: CGRect(x: 150, y: 200, width: 200, height: 200))
        testView.backgroundColor = .white
        self.view.addSubview(testView)
    }
}

class TestView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.red.cgColor)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 40, y: 20))
        path.addLine(to: CGPoint(x: 45, y: 40))
        path.addLine(to: CGPoint(x: 65, y: 40))
        path.addLine(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 60, y: 70))
        path.addLine(to: CGPoint(x: 40, y: 55))
        path.addLine(to: CGPoint(x: 20, y: 70))
        path.addLine(to: CGPoint(x: 30, y: 50))
        path.addLine(to: CGPoint(x: 15, y: 40))
        path.addLine(to: CGPoint(x: 35, y: 40))
        path.close()
        //path.stroke()
        
        let testLayer = CAShapeLayer()
        testLayer.fillColor = UIColor.clear.cgColor
        testLayer.strokeColor = UIColor.red.cgColor
        testLayer.path = path.cgPath
        testLayer.strokeStart = 0
        testLayer.strokeEnd = 0
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.speed = 0.05
        pathAnimation.repeatCount = Float.infinity
        //testLayer.add(pathAnimation, forKey: nil)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.2
        strokeEndAnimation.toValue = 1.2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 5
        animationGroup.repeatCount = Float.infinity
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        testLayer.add(animationGroup, forKey: nil)
        
        self.layer.addSublayer(testLayer)
        
//        let circleLayer = CAShapeLayer()
//        circleLayer.backgroundColor = UIColor.red.cgColor
//        circleLayer.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
//        circleLayer.position = CGPoint(x: 40, y: 20)
//        //circleLayer.cornerRadius = 5
//
//        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
//        followPathAnimation.path = path.cgPath
//        followPathAnimation.calculationMode = CAAnimationCalculationMode.cubicPaced
//        followPathAnimation.speed = 0.05
//        followPathAnimation.repeatCount = Float.infinity
//        circleLayer.add(followPathAnimation, forKey: nil)
//
//        self.layer.addSublayer(circleLayer)
    }
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
