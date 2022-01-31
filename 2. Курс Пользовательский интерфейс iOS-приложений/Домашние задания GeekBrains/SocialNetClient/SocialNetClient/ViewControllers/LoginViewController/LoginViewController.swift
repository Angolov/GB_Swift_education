//
//  LoginViewController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - LoginViewController class declaration
final class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextFiled: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    //MARK: - Properties
    let fromLoginToLoadingView = "fromLoginToLoadingView"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidHideNotification,
                                                  object: nil)
    }
    
    //MARK: - Keyboard notifications selectors
    @objc func keyboardDidShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey],
              let keyboardHeight = (keyboardFrame as? NSValue)?.cgRectValue.height else { return }
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK: - Private methods
    private func sendAlert() {
        
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Введены неверные логин/пароль",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkLoginData() -> Bool {
        
        guard let login = loginTextField.text,
              let password = passwordTextFiled.text else { return false }
        
        if login == "admin",
           password == "admin" {
            return true
            
        } else {
            return false
        }
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
       
        //if checkLoginData() {
        if true {
            print("Login successful")
            performSegue(withIdentifier: fromLoginToLoadingView, sender: nil)
            
        } else {
            print("Login unsuccessful")
            sendAlert()
        }
    }

}
