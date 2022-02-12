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
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                    action: #selector(hideKeyboard)))
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
    private func checkUserData() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == "admin",
              password == "123456" else { return false }
        
        return true
    }
    
    private func showLoginError() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Error",
                                      message: "Wrong user login/password",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
