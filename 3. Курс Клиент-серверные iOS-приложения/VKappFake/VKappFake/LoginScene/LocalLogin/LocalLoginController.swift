//
//  LocalLoginController.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 15.12.2021.
//

import UIKit

/// Локальный сценарий авторизации пользователя
final class LocalLoginController: UIViewController {

	// MARK: - SubViews
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()

	private lazy var vkLogo: UIImageView = {
		let vkLogo = UIImageView()
		vkLogo.image = UIImage(named: "vkLogo")
		vkLogo.backgroundColor = .clear
		vkLogo.translatesAutoresizingMaskIntoConstraints = false
		return vkLogo
	}()

	private lazy var loginLabel: UILabel = {
		let loginLabel = UILabel()
		loginLabel.text = "Логин"
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		return loginLabel
	}()

	private lazy var loginInput: UITextField = {
		let loginInput = UITextField()
		loginInput.backgroundColor = .white
		loginInput.layer.borderWidth = 1
		loginInput.layer.borderColor = UIColor.black.cgColor
		loginInput.layer.cornerRadius = 8
		loginInput.font = UIFont.systemFont(ofSize: 14)
		loginInput.textColor = .black
		loginInput.backgroundColor = .white
		loginInput.textAlignment = .left
		loginInput.translatesAutoresizingMaskIntoConstraints = false
		return loginInput
	}()

	private lazy var passwordLabel: UILabel = {
		let passwordLabel = UILabel()
		passwordLabel.text = "Пароль"
		passwordLabel.translatesAutoresizingMaskIntoConstraints = false
		return passwordLabel
	}()

	private lazy var passwordInput: UITextField = {
		let passwordInput = UITextField()
		passwordInput.backgroundColor = .white
		passwordInput.layer.borderWidth = 1
		passwordInput.layer.borderColor = UIColor.black.cgColor
		passwordInput.layer.cornerRadius = 8
		passwordInput.font = UIFont.systemFont(ofSize: 14)
		passwordInput.textColor = .black
		passwordInput.backgroundColor = .white
		passwordInput.textAlignment = .left
		passwordInput.translatesAutoresizingMaskIntoConstraints = false
		return passwordInput
	}()

	private lazy var loginButton: UIButton = {
		let loginButton = UIButton()
		loginButton.setTitle("Войти", for: .normal)
		loginButton.layer.borderColor = UIColor.black.cgColor
		loginButton.layer.borderWidth = 1
		loginButton.layer.cornerRadius = 8
		loginButton.setTitleColor(.black, for: .normal)
		loginButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
		loginButton.translatesAutoresizingMaskIntoConstraints = false
		return loginButton
	}()

	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupConstraints()
	}

	// MARK: - Action
	@objc func buttonPressed() {

	}
}

// MARK: - Private
private extension LocalLoginController {
	func setupNavigationBar() {}

	func setupView() {
		let gradientView = GradientView()
		gradientView.startColor = #colorLiteral(red: 0.442997694, green: 0.8187089562, blue: 1, alpha: 1)
		gradientView.endColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
		gradientView.endPoint = CGPoint(x: -0.6, y: 0.8)
		scrollView.backgroundColor = .clear
		self.view = gradientView
		self.view.addSubview(scrollView)
		[vkLogo, loginLabel, loginInput, passwordLabel, passwordInput, loginButton].forEach { scrollView.addSubview($0) }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

			vkLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
			vkLogo.widthAnchor.constraint(equalToConstant: 140),
			vkLogo.heightAnchor.constraint(equalToConstant: 150),
			vkLogo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -90),
			vkLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

			loginLabel.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 20),
			loginLabel.centerXAnchor.constraint(equalTo: vkLogo.centerXAnchor),

			loginInput.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
			loginInput.widthAnchor.constraint(equalToConstant: 250),
			loginInput.heightAnchor.constraint(equalToConstant: 30),
			loginInput.centerXAnchor.constraint(equalTo: vkLogo.centerXAnchor),

			passwordLabel.topAnchor.constraint(equalTo: loginInput.bottomAnchor, constant: 20),
			passwordLabel.centerXAnchor.constraint(equalTo: vkLogo.centerXAnchor),

			passwordInput.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
			passwordInput.centerXAnchor.constraint(equalTo: vkLogo.centerXAnchor),
			passwordInput.widthAnchor.constraint(equalToConstant: 250),
			passwordInput.heightAnchor.constraint(equalToConstant: 30),

			loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 20),
			loginButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50),
			loginButton.centerXAnchor.constraint(equalTo: vkLogo.centerXAnchor),
			loginButton.widthAnchor.constraint(equalToConstant: 70),
			loginButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
