//
//  LoginViewController.swift
//  TSD_lesson5
//
//  Created by Антон Головатый on 25.01.2022.
//

import UIKit

//MARK: - LoginViewController class declaration
final class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var eyeButton: UIButton!
    
    //MARK: - Public properties
    let fromLoginViewToBirthdayView = "fromLoginViewToBirthdayView"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
//        if email == "admin@yahoo.com",
//           password == "12345" {
        if true {
            performSegue(withIdentifier: fromLoginViewToBirthdayView, sender: nil)
        }
        
    }
    
    @IBAction func eyeButtonPressed(_ sender: Any) {
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordTextField.isSecureTextEntry = false
    }
    
    @IBAction func eyeButtonTouchCanceled(_ sender: Any) {
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordTextField.isSecureTextEntry = true
    }
    
}
