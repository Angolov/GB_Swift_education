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
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        setupView()
        loadAuth()
    }
    
    //MARK: - Private methods
    private func setupView() {
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func loadAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8078935"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups, wall"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func addNewUserIfNecessary(with userId: String) {
        let storage = UserDefaults.standard
        let storageKey = "userID"
        let currentUserID = storage.object(forKey: storageKey) as? String
        
        if userId != currentUserID {
            storage.set(userId, forKey: storageKey)

            let currentUser = VKUser()
            currentUser.userId = userId
            
            do {
                let realm = try Realm()
                let oldUsers = realm.objects(VKUser.self)
                
                realm.beginWrite()
    
                for user in oldUsers {
                    let oldGroupsData = user.groups
                    let oldFriendsData = user.friends
                    let oldPhotosData = user.photos
                    for photo in oldPhotosData {
                        realm.delete(photo.sizes)
                    }
                    realm.delete(oldPhotosData)
                    realm.delete(oldFriendsData)
                    realm.delete(oldGroupsData)
                }
                realm.delete(oldUsers)
                
                realm.add(currentUser)
                try realm.commitWrite()
            }
            catch {
                print(error)
            }
        }
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
            
            addNewUserIfNecessary(with: userId)
            
            performSegue(withIdentifier: fromWebLoginViewToTabBar, sender: nil)
        }
    }
}
