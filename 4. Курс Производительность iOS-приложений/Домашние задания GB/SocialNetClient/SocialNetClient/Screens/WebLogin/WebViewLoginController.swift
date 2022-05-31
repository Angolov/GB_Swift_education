//
//  WebViewLoginController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 17.02.2022.
//

import UIKit
import WebKit
import RealmSwift

//MARK: - WebViewLoginController class declaration
final class WebViewLoginController: UIViewController {

    //MARK: - UI elements
    lazy private var webView: WKWebView = {
        let view = WKWebView()
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Private properties
    private var session = Session.instance
    private let fromWebLoginViewToTabBar = "fromWebLoginViewToTabBar"
    private let authRequest = AuthRequest()
    private let storage = RealmStorage.shared
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        setupView()
        if let request = authRequest.getAuthForm() {
            webView.load(request)
        }
    }
    
    //MARK: - Private methods
    private func setupView() {
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

//MARK: - WKNavigationDelegate
extension WebViewLoginController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
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
        
        if let token = params["access_token"],
           let userId = params["user_id"] {
            session.token = token
            session.userID = userId
            decisionHandler(.cancel)
            
            storage.addNewMainUserIfNecessary(with: userId)
            
            performSegue(withIdentifier: fromWebLoginViewToTabBar, sender: nil)
        }
    }
}
