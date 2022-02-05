//
//  LoginViewController.swift
//  TSD_lesson_9-10
//
//  Created by Антон Головатый on 31.01.2022.
//

import UIKit

//MARK: - LoginViewController class declaration
final class LoginViewController: UIViewController {

    //MARK: - UI elements
    private var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var phoneLabel: UILabel!
    private var phoneTextField: UITextField!
    private var phoneLineView: UIView!
    private var passwordLabel: UILabel!
    private var passwordTextField: UITextField!
    
    private var eyeButton: UIButton = {
        var eyeButton = UIButton(type: .custom)
        let eyeImageFilled = UIImage(systemName: "eye.fill")
        let eyeImage = UIImage(systemName: "eye")
        eyeButton.setImage(eyeImage, for: .normal)
        eyeButton.setImage(eyeImageFilled, for: .highlighted)
        eyeButton.tintColor = .lightGray
        
        eyeButton.addTarget(self, action: #selector(eyeButtonPressed(_:)), for: .touchDown)
        eyeButton.addTarget(self, action: #selector(eyeButtonReleased(_:)), for: .touchUpInside)
        
        return eyeButton
    }()
    
    private var passwordLineView: UIView!
    
    private var loginButton: UIButton = {
        var loginButton = UIButton()
        loginButton.backgroundColor = #colorLiteral(red: 0.6573816538, green: 0.7767691612, blue: 0.9821795821, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 0.4
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        
        return loginButton
    }()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true

        phoneLabel = createTextLabelWith(text: "Phone number")
        self.view.addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        phoneTextField = createTextFieldWith(placeholder: "Enter phone number here")
        phoneTextField.text = "8 900 000 00 00"
        phoneTextField.keyboardType = .phonePad
        self.view.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 0).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.leadingAnchor).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: phoneLabel.trailingAnchor).isActive = true
        phoneTextField.heightAnchor.constraint(equalTo: phoneLabel.heightAnchor).isActive = true

        phoneLineView = createLineView()
        self.view.addSubview(phoneLineView)
        phoneLineView.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10).isActive = true
        phoneLineView.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor).isActive = true
        phoneLineView.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor).isActive = true
        phoneLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        passwordLabel = createTextLabelWith(text: "Password")
        self.view.addSubview(passwordLabel)
        passwordLabel.topAnchor.constraint(equalTo: phoneLineView.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: phoneLineView.leadingAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: phoneLineView.trailingAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        passwordTextField = createTextFieldWith(placeholder: "Enter password here")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.defaultTextAttributes.updateValue(3, forKey: .kern)
        passwordTextField.text = "12345678901"
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        
        self.view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: passwordLabel.heightAnchor).isActive = true

        passwordLineView = createLineView()
        self.view.addSubview(passwordLineView)
        passwordLineView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        passwordLineView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        passwordLineView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        passwordLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        self.view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordLineView.bottomAnchor, constant: 110).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: passwordLineView.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: passwordLineView.trailingAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func createTextLabelWith(text: String) -> UILabel {
        let textLabel = UILabel()
        textLabel.textColor = #colorLiteral(red: 0.6239495277, green: 0.7334806323, blue: 0.9304007888, alpha: 1)
        textLabel.text = text
        textLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }
    
    private func createTextFieldWith(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = UIColor.black
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }
    
    private func createLineView() -> UIView {
        let lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.9215686321, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        return lineView
    }
    
    //MARK: - Actions
    @objc func loginButtonPressed(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: FoodViewController())
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        present(navController, animated: true, completion: nil)
    }
    
    @objc func eyeButtonPressed(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = false
    }
    
    @objc func eyeButtonReleased(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = true
    }
}
