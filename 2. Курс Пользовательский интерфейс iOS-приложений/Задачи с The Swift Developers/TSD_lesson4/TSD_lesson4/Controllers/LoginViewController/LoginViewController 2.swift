//
//  LoginViewController.swift
//  TSD_lesson4
//
//  Created by Антон Головатый on 24.01.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let fromLoginToCafeView = "fromLoginToCafeView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
//        if email == "admin@yahoo.com",
//           password == "12345" {
        if true {
            performSegue(withIdentifier: fromLoginToCafeView, sender: nil)
            
        } else {
            let alertController = UIAlertController(title: "Login failed",
                                                    message: "Wrong email or password",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok",
                                                    style: .default,
                                                    handler: nil))
            self.present(alertController, animated: true, completion: nil)
                                      
        }
    }
    
}
