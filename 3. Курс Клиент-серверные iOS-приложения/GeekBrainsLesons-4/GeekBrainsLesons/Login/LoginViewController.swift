//
//  LoginViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoLable: UILabel!
    @IBOutlet weak var loginLable: UILabel!
    @IBOutlet weak var textLoginLable: UITextField!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var textPasswordLable: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingView: UIView!

	// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self,
											   selector: #selector(self.keyboardWasShown),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil
		)

        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self,
											   selector: #selector(self.keyboardWillBeHidden(notification:)),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil
		)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startLoadingView()
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
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {}

	/// Клавиатура появилась
	/// - Parameter notification: Уведомление
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
	}

    // Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // Добавим проверку данных введенных данных
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        if !checkResult {
            showLoginError()
        }
        return checkResult
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Error",
									  message: "Введены неверные данные пользователя",
									  preferredStyle: .alert
		)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIScrollViewDelegate
// метод который отменяет скролл экрана по оси Х
extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

// MARK: - Private
private extension LoginViewController {
	func checkUserData() -> Bool {
		guard
			let login = textLoginLable.text,
			let password = textPasswordLable.text
		else {
			return false
		}
		if login == "admin" && password == "123456" {
			return true
		} else {
			return false
		}
	}

	// MARK: - animate loading

	func startLoadingView() {

		let cloudView = UIView()

		view.addSubview(cloudView)
		cloudView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			cloudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			cloudView.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: -10),
			cloudView.widthAnchor.constraint(equalToConstant: 120),
			cloudView.heightAnchor.constraint(equalToConstant: 70)
		])

		let path = UIBezierPath()
		path.move(to: CGPoint(x: 10, y: 60))
		path.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 45))
		path.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
		path.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
		path.addQuadCurve(to: CGPoint(x: 90, y: 40), controlPoint: CGPoint(x: 90, y: 20))
		path.addQuadCurve(to: CGPoint(x: 105, y: 60), controlPoint: CGPoint(x: 110, y: 45))
		path.close()

		let layerAnimation = CAShapeLayer()
		layerAnimation.path = path.cgPath
		layerAnimation.strokeColor = UIColor.systemIndigo.cgColor
		layerAnimation.fillColor = UIColor.clear.cgColor
		layerAnimation.lineWidth = 6
		layerAnimation.lineCap = .round

		cloudView.layer.addSublayer(layerAnimation)

        let startLoadingViewStart = CABasicAnimation(keyPath: "strokeStart")
        startLoadingViewStart.fromValue = 0
        startLoadingViewStart.toValue = 5 // задаем скорость рисования
        startLoadingViewStart.duration = 2
        startLoadingViewStart.fillMode = .both
        startLoadingViewStart.isRemovedOnCompletion = false
        startLoadingViewStart.beginTime = 1 // задаем время до следущего повтора анимации
        
        let startLoadingViewEnd = CABasicAnimation(keyPath: "strokeEnd")
        startLoadingViewEnd.fromValue = 0
        startLoadingViewEnd.duration = 2
        startLoadingViewEnd.toValue = 5 // задаем скорость рисования
        startLoadingViewEnd.fillMode = .both
        startLoadingViewEnd.isRemovedOnCompletion = false
        layerAnimation.add(startLoadingViewEnd, forKey: nil)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.5 // время до повтора анимации
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [startLoadingViewStart, startLoadingViewEnd]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)
    }
    
    
}
