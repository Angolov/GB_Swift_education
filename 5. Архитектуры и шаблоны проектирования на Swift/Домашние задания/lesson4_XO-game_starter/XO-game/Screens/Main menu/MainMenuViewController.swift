//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Антон Головатый on 06.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

// MARK: - MainMenuViewController class declaration

final class MainMenuViewController: UIViewController {
    
    // MARK: - UI elements
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Tic-Tac-Toe"
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    lazy var singlePlayerGameButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .link
        button.layer.cornerRadius = 10
        button.setTitle("Single player", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(singlePlayerGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var multiPlayerGameButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .link
        button.layer.cornerRadius = 10
        button.setTitle("Multiplayer", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(multiPlayerGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var blindGameButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .link
        button.layer.cornerRadius = 10
        button.setTitle("Blind game mode", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(blindGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(mainLabel)
        self.view.addSubview(singlePlayerGameButton)
        self.view.addSubview(multiPlayerGameButton)
        self.view.addSubview(blindGameButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let inset: CGFloat = 10
        let width = self.view.width - inset * 2
        let height: CGFloat = 52
        mainLabel.frame = CGRect(x: inset,
                                 y: self.view.height / 3,
                                 width: width,
                                 height: height)
        singlePlayerGameButton.frame = CGRect(x: self.view.center.x - width / 4,
                                              y: mainLabel.bottom + inset * 3,
                                              width: width / 2,
                                              height: height / 3 * 2)
        multiPlayerGameButton.frame = CGRect(x: singlePlayerGameButton.left,
                                             y: singlePlayerGameButton.bottom + inset,
                                             width: singlePlayerGameButton.width,
                                             height: singlePlayerGameButton.height)
        blindGameButton.frame = CGRect(x: singlePlayerGameButton.left,
                                       y: multiPlayerGameButton.bottom + inset,
                                       width: singlePlayerGameButton.width,
                                       height: singlePlayerGameButton.height)
    }
    
    // MARK: - Actions
    
    @objc func singlePlayerGameButtonTapped() {
        let vc = GameViewController()
        vc.gameMode = .singlePlayer
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func multiPlayerGameButtonTapped() {
        let vc = GameViewController()
        vc.gameMode = .multiPlayer
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func blindGameButtonTapped() {
        let vc = GameViewController()
        vc.gameMode = .blindGame
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
