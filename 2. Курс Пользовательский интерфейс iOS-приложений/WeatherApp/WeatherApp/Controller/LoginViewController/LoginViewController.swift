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
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                    action: #selector(hideKeyboard)))
        setupView()
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
        let offset = self.view.bounds.width
        loginLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordLabel.transform = CGAffineTransform(translationX: offset, y: 0)
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            guard let self = self else { return }
            self.loginLabel.transform = .identity
            self.passwordLabel.transform = .identity
        }, completion: nil)
    }
    
    func animateTitleAppearing() {
        self.titleLabel.transform = CGAffineTransform(translationX: 0,
                                                     y: -self.view.bounds.height/2)
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            guard let self = self else { return }
            self.titleLabel.transform = .identity
        }, completion: nil)
    }
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        self.loginTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
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
