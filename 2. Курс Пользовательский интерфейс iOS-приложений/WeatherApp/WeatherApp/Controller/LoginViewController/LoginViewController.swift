//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - LoginViewController class declaration
final class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                    action: #selector(hideKeyboard)))
        setupView()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    //MARK: - Objc handlers
    @objc func keyboardWasShown(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let value = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else { return }
        
        let keyBoardHeight = value.cgRectValue.size.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardHeight, right: 0.0)
        self.mainScrollView?.contentInset = contentInsets
        mainScrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        mainScrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.mainScrollView?.endEditing(true)
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: { [weak self] in
                guard let self = self else { return }
                self.enterButton.transform = CGAffineTransform(translationX: 0, y: 150)
            })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 150
        case .ended:
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.enterButton.transform = .identity
            }
            interactiveAnimator.startAnimation()
        default: return
        }
    }
    
    //MARK: - Private methods
    private func setupView() {
        enterButton.layer.cornerRadius = 15
        enterButton.layer.shadowColor = UIColor.black.cgColor
        enterButton.layer.shadowRadius = 5
        enterButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        enterButton.layer.shadowOpacity = 0.7
        enterButton.setAttributedTitle(NSAttributedString(string: "Enter",
                                                          attributes: [.font: UIFont.systemFont(ofSize: 16,
                                                                                                weight: .bold)]),
                                       for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.setTitleColor(.lightGray, for: .highlighted)
        
        animateTitleAppearing()
        animateTitlesAppearing()
        animateFieldsAppearing()
        animateAuthButton()
    }
    
    private func checkUserData() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == "admin",
              password == "123456" else { return false }
        
        return true
    }
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Error",
                                      message: "Wrong user login/password",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Animations
    func animateTitlesAppearing() {
        let offset = abs(self.loginLabel.frame.midY - self.passwordLabel.frame.midY)
        self.loginLabel.transform = CGAffineTransform(translationX: 0, y: offset)
        self.passwordLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModeCubicPaced,
                                animations: { [weak self] in
            guard let self = self else { return }
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.5,
                               animations: {
                self.loginLabel.transform = CGAffineTransform(translationX: 150, y: 50)
                self.passwordLabel.transform = CGAffineTransform(translationX: -150, y: -50)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 0.5, animations: {
                self.loginLabel.transform = .identity
                self.passwordLabel.transform = .identity
            })
        }, completion: nil)
    }
    
    func animateTitleAppearing() {
        self.titleLabel.transform = CGAffineTransform(translationX: 0,
                                                     y: -self.view.bounds.height/2)
        
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5,
                                              animations: { [weak self] in
            guard let self = self else { return }
            self.titleLabel.transform = .identity
        })
        animator.startAnimation(afterDelay: 1)
    }
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 1
        animationsGroup.beginTime = CACurrentMediaTime() + 1
        animationsGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
        animationsGroup.animations = [fadeInAnimation, scaleAnimation]
        
        self.loginTextField.layer.add(animationsGroup, forKey: nil)
        self.passwordTextField.layer.add(animationsGroup, forKey: nil)
    }
    
    func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.enterButton.layer.add(animation, forKey: nil)
    }
    
    //MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        let checkResult = checkUserData()
//        if !checkResult {
//            showLoginError()
//        }
//        return checkResult
        return true
    }
    
    //MARK: - Actions
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        if let login = loginTextField.text,
           let password = passwordTextField.text,
           login == "admin",
           password == "123456" {
            
            print("успешная авторизация")
            
        } else {
            print("неуспешная авторизация")
        }
    }
}
