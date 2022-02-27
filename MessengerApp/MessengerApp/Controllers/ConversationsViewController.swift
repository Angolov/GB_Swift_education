//
//  ConversationsViewController.swift
//  MessengerApp
//
//  Created by Антон Головатый on 24.02.2022.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }

    private func validateAuth() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            let appearence = UINavigationBarAppearance()
            appearence.backgroundColor = .white
            nav.navigationBar.compactAppearance = appearence
            nav.navigationBar.standardAppearance = appearence
            nav.navigationBar.scrollEdgeAppearance = appearence
            nav.navigationBar.compactScrollEdgeAppearance = appearence
            
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        }
    }

}

