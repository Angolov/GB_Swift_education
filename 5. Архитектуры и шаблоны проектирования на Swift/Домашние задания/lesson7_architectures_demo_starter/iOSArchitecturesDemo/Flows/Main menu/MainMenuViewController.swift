//
//  MainMenuViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {
    
    // MARK: - UI elements
    
    private lazy var appsSearchButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .blue
        button.setTitle("Apps search", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(appsSearchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var songsSearchButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .blue
        button.setTitle("Songs search", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(songsSearchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .flipHorizontal
        return navVC
    }()
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(appsSearchButton)
        view.addSubview(songsSearchButton)
        
        setupConstraints()
    }
    
    // MARK: - Actions
    
    @objc func appsSearchButtonTapped() {
        let vc = SearchModuleBuilder.build()
        vc.navigationItem.title = "Search via iTunes"

        let navVC = self.configuredNavigationController
        navVC.viewControllers = [vc]
        
        present(navVC, animated: true)
    }
    
    @objc func songsSearchButtonTapped() {
        let vc = SongSearchModuleBuilder.build()
        vc.navigationItem.title = "Search via iTunes"

        let navVC = self.configuredNavigationController
        navVC.viewControllers = [vc]
        
        present(navVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            appsSearchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appsSearchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30.0),
            appsSearchButton.heightAnchor.constraint(equalToConstant: 45.0),
            appsSearchButton.widthAnchor.constraint(equalToConstant: 200.0),
            songsSearchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songsSearchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30.0),
            songsSearchButton.heightAnchor.constraint(equalToConstant: 45.0),
            songsSearchButton.widthAnchor.constraint(equalToConstant: 200.0)
        ])
    }
}
