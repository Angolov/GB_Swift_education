//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = TestView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.backgroundColor = .white
        self.view = view
    }
}

class TestView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let firstLayer = CAShapeLayer()
        let secondLayer = CAShapeLayer()
        firstLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 4, height: 4)).cgPath
        secondLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 4, height: 4)).cgPath
        firstLayer.backgroundColor = UIColor.black.cgColor
        secondLayer.backgroundColor = UIColor.black.cgColor
        firstLayer.frame = CGRect(x: 100, y: 100, width: 4, height: 4)
        secondLayer.frame = CGRect(x: 100, y: 100, width: 4, height: 4)
        firstLayer.masksToBounds = true
        secondLayer.masksToBounds = true
        firstLayer.cornerRadius = 2
        secondLayer.cornerRadius = 2
        
        self.layer.addSublayer(firstLayer)
        self.layer.addSublayer(secondLayer)
        
        let scale = CABasicAnimation(keyPath: "bounds.size.width")
        scale.byValue = 100
        scale.duration = 1
        scale.fillMode = CAMediaTimingFillMode.forwards
        scale.isRemovedOnCompletion = false
        
        let rotationLeft = CABasicAnimation(keyPath: "transform.rotation")
        rotationLeft.byValue = CGFloat.pi / 4
        rotationLeft.duration = 1
        rotationLeft.beginTime = CACurrentMediaTime() + 1
        rotationLeft.fillMode = CAMediaTimingFillMode.both
        rotationLeft.isRemovedOnCompletion = false
        
        let rotationRight = CABasicAnimation(keyPath: "transform.rotation")
        rotationRight.byValue = -CGFloat.pi / 4
        rotationRight.duration = 1
        rotationRight.beginTime = CACurrentMediaTime() + 1
        rotationRight.fillMode = CAMediaTimingFillMode.both
        rotationRight.isRemovedOnCompletion = false
        
        firstLayer.add(scale, forKey: nil)
        firstLayer.add(rotationLeft, forKey: nil)
        secondLayer.add(scale, forKey: nil)
        secondLayer.add(rotationRight, forKey: nil)
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
