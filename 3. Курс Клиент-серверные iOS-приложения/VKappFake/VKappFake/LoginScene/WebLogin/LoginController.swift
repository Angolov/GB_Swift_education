//
//  LoginController.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 15.12.2021.
//

import UIKit
import WebKit

class LoginController: UIViewController {

	// MARK: - SubView
	private lazy var webView: WKWebView = {
		let webConfiguration = WKWebViewConfiguration()
		let view = WKWebView(frame: .zero, configuration: webConfiguration)
		return view
	}()

	// MARK: -LifeCycle
	override func loadView() {
		super.loadView()
		self.view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		configureWebView()
		loadAuth()
	}
}

// MARK: - WKNavigationDelegate
extension LoginController: WKNavigationDelegate {
	func configureWebView() {
		webView.navigationDelegate = self
	}

	/// Перехватывает ответы сервера при переходе, можно отменить при необходимости.
	func webView(_ webView: WKWebView,
				 decidePolicyFor navigationResponse: WKNavigationResponse,
				 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

		// проверяем, что ответ существует и путь не пустой
		guard let url = navigationResponse.response.url,
			  url.path == "/blank.html",
			  let fragment = url.fragment
		else {
			decisionHandler(.allow)
			return
		}

		let params = fragment
			.components(separatedBy: "&")
			.map { $0.components(separatedBy: "=") }
			.reduce([String: String]()) { result, param in
				var dict = result
				let key = param[0]
				let value = param[1]
				dict[key] = value
				return dict
			}
		
		// Сохраняем данные авторизации, если она успешна и всё нужное есть
		if let token = params["access_token"],
		   let userId = params["user_id"],
		   let id = Int(userId) {
			SessionStorage.instance.loginUser(with: token, userId: id)
			self.navigationController?.pushViewController(CustomTabBarController(), animated: true)
		}
		decisionHandler(.cancel)
	}
}

// MARK: - Private
private extension LoginController {
	func loadAuth() {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "oauth.vk.com"
		urlComponents.path = "/authorize"
		urlComponents.queryItems = [
			URLQueryItem(name: "client_id", value: "8002318"),
			URLQueryItem(name: "display", value: "mobile"),
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
			URLQueryItem(name: "scope", value: "friends, photos, wall, groups"),
			URLQueryItem(name: "response_type", value: "token"),
			URLQueryItem(name: "v", value: "5.131")
		]

		let request = URLRequest(url: urlComponents.url!)

		webView.load(request)
	}
}
