//
//  LoginViewController.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 05.02.2022.
//

import UIKit

//MARK: - LoginViewController class declaration
class LoginViewController: UIViewController {

    //MARK: - Base UI elements
    private var mainView: UIView!
    private lazy var logoImageView: UIImageView = {
        var logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return logoImageView
    }()
    
    //MARK: - Login UI elements
    private var phoneLabel: UILabel!
    private var phoneTextField: UITextField!
    private var passwordLabel: UILabel!
    private var passwordTextField: UITextField!
    private lazy var switchViewModeButton: UIButton = {
        var switchViewModeButton = UIButton(type: .custom)
        switchViewModeButton.setTitle("Don't have an account yet? Register here...", for: .normal)
        let titleColor = #colorLiteral(red: 0.008574218489, green: 0.6101772785, blue: 0.8241466284, alpha: 1)
        switchViewModeButton.setTitleColor(titleColor, for: .normal)
        switchViewModeButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        switchViewModeButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchViewModeButton.addTarget(self, action: #selector(switchViewButtonPressed(_:)), for: .touchUpInside)
        
        return switchViewModeButton
    }()
    private lazy var proceedButton: UIButton = {
        var proceedButton = UIButton(type: .custom)
        proceedButton.backgroundColor = #colorLiteral(red: 0.9009638429, green: 0.3160782158, blue: 0.07701078802, alpha: 1)
        proceedButton.setTitle("Login", for: .normal)
        proceedButton.setTitleColor(.white, for: .normal)
        proceedButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        proceedButton.layer.cornerRadius = 10
        proceedButton.layer.shadowColor = UIColor.lightGray.cgColor
        proceedButton.layer.shadowRadius = 5
        proceedButton.layer.shadowOpacity = 0.4
        proceedButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        
        proceedButton.addTarget(self, action: #selector(proceedButtonPressed(_:)), for: .touchUpInside)
        
        return proceedButton
    }()
    
    //MARK: - Registration form addition UI elements
    private var nameLabel: UILabel!
    private var nameTextField: UITextField!
    private var repeatPasswordLabel: UILabel!
    private var repeatPasswordTextField: UITextField!
    
    //MARK: - Private properties
    private let loginTitle = "Don't have an account yet? Register here..."
    private let registerTitle = "Already have an account? Login here..."
    private let fromLoginToTabBarView = "fromLoginToTabBarView"
    private var isRegisterView = false
    
    private var textFieldsCollection = [UITextField]()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: nil) { [weak self] nc in
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                self.mainView.frame.origin.y = -150
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: nil) { [weak self] nc in
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                self.mainView.frame.origin.y = 0
            }
        }
    }
    
    //MARK: - Private methods
    private func initializeMainView() {
        
        mainView = UIView()
        mainView.frame = self.view.bounds
        self.view.addSubview(mainView)
        
        self.view.addSubview(logoImageView)
        logoImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 60).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: mainView.frame.width / 2).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: mainView.frame.width / 2).isActive = true
    }
    
    //MARK: - Setup for login view
    private func setupLoginView() {
        
        initializeMainView()
        mainView.backgroundColor = .white
        
        phoneLabel = createTextLabelWith(text: "Phone number")
        self.mainView.addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        phoneTextField = createTextFieldWith(placeholder: "Enter phone number here")
        phoneTextField.text = "8 900 000 00 00"
        phoneTextField.keyboardType = .phonePad
        textFieldsCollection.append(phoneTextField)
        self.mainView.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 0).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.leadingAnchor).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: phoneLabel.trailingAnchor).isActive = true
        phoneTextField.heightAnchor.constraint(equalTo: phoneLabel.heightAnchor).isActive = true

        passwordLabel = createTextLabelWith(text: "Password")
        self.mainView.addSubview(passwordLabel)
        passwordLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        passwordTextField = createTextFieldWith(placeholder: "Enter password here",
                                                secureTextEntry: true,
                                                tag: 1)
        passwordTextField.text = "12345678901"
        textFieldsCollection.append(passwordTextField)
        self.mainView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: passwordLabel.heightAnchor).isActive = true
        
        self.mainView.addSubview(switchViewModeButton)
        switchViewModeButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        switchViewModeButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        switchViewModeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        switchViewModeButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive = true
        
        self.mainView.addSubview(proceedButton)
        proceedButton.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -100).isActive = true
        proceedButton.leadingAnchor.constraint(equalTo: switchViewModeButton.leadingAnchor).isActive = true
        proceedButton.trailingAnchor.constraint(equalTo: switchViewModeButton.trailingAnchor).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    //MARK: - Setup for registration view
    private func setupRegistrationView() {
        
        initializeMainView()
        
        nameLabel = createTextLabelWith(text: "Name")
        self.mainView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        nameTextField = createTextFieldWith(placeholder: "Enter your name here")
        textFieldsCollection.append(nameTextField)
        self.mainView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
        phoneLabel = createTextLabelWith(text: "Phone number")
        self.mainView.addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        phoneTextField = createTextFieldWith(placeholder: "Enter phone number here")
        phoneTextField.keyboardType = .phonePad
        textFieldsCollection.append(phoneTextField)
        self.mainView.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 0).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.leadingAnchor).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: phoneLabel.trailingAnchor).isActive = true
        phoneTextField.heightAnchor.constraint(equalTo: phoneLabel.heightAnchor).isActive = true

        passwordLabel = createTextLabelWith(text: "Password")
        self.mainView.addSubview(passwordLabel)
        passwordLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        passwordTextField = createTextFieldWith(placeholder: "Enter password here",
                                                secureTextEntry: true,
                                                tag: 1)
        textFieldsCollection.append(passwordTextField)
        self.mainView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: passwordLabel.heightAnchor).isActive = true
        
        repeatPasswordLabel = createTextLabelWith(text: "Repeat password")
        self.mainView.addSubview(repeatPasswordLabel)
        repeatPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                 constant: 20).isActive = true
        repeatPasswordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        repeatPasswordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        repeatPasswordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        repeatPasswordTextField = createTextFieldWith(placeholder: "Repeat password here",
                                                      secureTextEntry: true,
                                                      tag: 2)
        textFieldsCollection.append(repeatPasswordTextField)
        self.mainView.addSubview(repeatPasswordTextField)
        repeatPasswordTextField.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor,
                                                     constant: 0).isActive = true
        repeatPasswordTextField.leadingAnchor.constraint(equalTo: repeatPasswordLabel.leadingAnchor).isActive = true
        repeatPasswordTextField.trailingAnchor.constraint(equalTo: repeatPasswordLabel.trailingAnchor).isActive = true
        repeatPasswordTextField.heightAnchor.constraint(equalTo: repeatPasswordLabel.heightAnchor).isActive = true
        
        self.mainView.addSubview(switchViewModeButton)
        switchViewModeButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor,
                                                  constant: 0).isActive = true
        switchViewModeButton.leadingAnchor.constraint(equalTo: repeatPasswordTextField.leadingAnchor).isActive = true
        switchViewModeButton.trailingAnchor.constraint(equalTo: repeatPasswordTextField.trailingAnchor).isActive = true
        switchViewModeButton.heightAnchor.constraint(equalTo: repeatPasswordTextField.heightAnchor).isActive = true
        
        self.mainView.addSubview(proceedButton)
        proceedButton.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -100).isActive = true
        proceedButton.leadingAnchor.constraint(equalTo: switchViewModeButton.leadingAnchor).isActive = true
        proceedButton.trailingAnchor.constraint(equalTo: switchViewModeButton.trailingAnchor).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    //MARK: - Methods for creation of UI elements
    private func createTextLabelWith(text: String) -> UILabel {
        let textLabel = UILabel()
        textLabel.textColor = #colorLiteral(red: 0.8871222138, green: 0.002708175452, blue: 0.1084542051, alpha: 1)
        textLabel.text = text
        textLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return textLabel
    }
    
    private func createTextFieldWith(placeholder: String,
                                     secureTextEntry: Bool = false,
                                     tag: Int = 0) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = #colorLiteral(red: 0.387313962, green: 0.1335606873, blue: 0.5070849657, alpha: 1)
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        if secureTextEntry {
            textField.isSecureTextEntry = true
            textField.defaultTextAttributes.updateValue(3, forKey: .kern)
            let eyeButton = createEyeButton(with: tag)
            
            textField.rightView = eyeButton
            textField.rightViewMode = .always
        }
        
        return textField
    }
    
    private func createEyeButton(with tag: Int) -> UIButton {
        let eyeButton = UIButton(type: .custom)
        let eyeImageFilled = UIImage(systemName: "eye.fill")
        let eyeImage = UIImage(systemName: "eye")
        eyeButton.setImage(eyeImage, for: .normal)
        eyeButton.setImage(eyeImageFilled, for: .highlighted)
        eyeButton.tintColor = #colorLiteral(red: 0.4835574627, green: 0.7781214118, blue: 0.7422924638, alpha: 1)
        eyeButton.tag = tag
        
        eyeButton.addTarget(self, action: #selector(eyeButtonPressed(_:)), for: .touchDown)
        eyeButton.addTarget(self, action: #selector(eyeButtonReleased(_:)), for: .touchUpInside)
        
        return eyeButton
    }
    
    //MARK: - Actions
    @objc func switchViewButtonPressed(_ sender: UIButton) {
        self.mainView.removeFromSuperview()
        
        if isRegisterView {
            textFieldsCollection = []
            setupLoginView()
            sender.setTitle(loginTitle, for: .normal)
            proceedButton.backgroundColor = #colorLiteral(red: 0.9009638429, green: 0.3160782158, blue: 0.07701078802, alpha: 1)
            proceedButton.setTitle("Login", for: .normal)
            proceedButton.setTitleColor(.white, for: .normal)
            
        } else {
            textFieldsCollection = []
            setupRegistrationView()
            sender.setTitle(registerTitle, for: .normal)
            proceedButton.backgroundColor = #colorLiteral(red: 0.008966139518, green: 0.5648388863, blue: 0.2099609375, alpha: 1)
            proceedButton.setTitle("Register", for: .normal)
            proceedButton.setTitleColor(.white, for: .normal)
        }
        
        isRegisterView = !isRegisterView
        
    }
    
    @objc func proceedButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: fromLoginToTabBarView, sender: nil)
    }
    
    @objc func eyeButtonPressed(_ sender: UIButton) {
        switch sender.tag{
        case 1: passwordTextField.isSecureTextEntry = false
        case 2: repeatPasswordTextField.isSecureTextEntry = false
        default: return
        }
    }
    
    @objc func eyeButtonReleased(_ sender: UIButton) {
        switch sender.tag{
        case 1: passwordTextField.isSecureTextEntry = true
        case 2: repeatPasswordTextField.isSecureTextEntry = true
        default: return
        }
    }
}

//MARK: - extension for UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFieldsCollection.firstIndex(of: textField) else { return true }
        
        if index < textFieldsCollection.count - 1 {
            textFieldsCollection[index + 1].becomeFirstResponder()
            
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
