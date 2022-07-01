//
//  MainMenuViewController.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 27.05.2022.
//

import UIKit

//MARK: - MainMenuViewController class declaration

final class MainMenuViewController: UIViewController {
    
    //MARK: - UI elements
    
    lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "gameLogo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var playButton: UIButton = {
        var button = UIButton()
        let title = NSAttributedString(string: "Играть",
                                       attributes: [.font: UIFont.systemFont(ofSize: 36, weight: .bold)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsButton: UIButton = {
       var button = UIButton()
        let title = NSAttributedString(string: "Настройки",
                                       attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var resultsButton: UIButton = {
        var button = UIButton()
        let title = NSAttributedString(string: "Результаты",
                                       attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var addQuestionButton: UIButton = {
        var button = UIButton()
        let title = NSAttributedString(string: "Добавить вопрос",
                                       attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addQuestionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoImageView.frame = CGRect(x: 0,
                                     y: self.view.center.y + 26 - self.view.width,
                                     width: self.view.width,
                                     height: self.view.width)
        playButton.frame = CGRect(x: 30,
                                  y: self.view.center.y + 52,
                                  width: self.view.width - 60,
                                  height: 52)
        settingsButton.frame = CGRect(x: 30,
                                      y: playButton.bottom + 10,
                                      width: self.view.width - 60,
                                      height: 28)
        resultsButton.frame = CGRect(x: 30,
                                     y: settingsButton.bottom + 10,
                                     width: self.view.width - 60,
                                     height: 28)
        addQuestionButton.frame = CGRect(x: 30,
                                         y: resultsButton.bottom + 100,
                                         width: self.view.width - 60,
                                         height: 28)
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        self.view.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        self.view.addSubview(logoImageView)
        self.view.addSubview(playButton)
        self.view.addSubview(settingsButton)
        self.view.addSubview(resultsButton)
        self.view.addSubview(addQuestionButton)
    }
    
    //MARK: - Actions
    
    @objc func playButtonTapped() {
        let vc = GameViewController()
        let selectedStrategy = Game.shared.questionSettings.questionStrategy
        Game.shared.gameSession = GameSession(questionStrategy: selectedStrategy)
        vc.session = Game.shared.gameSession
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsViewController()
        present(vc, animated: true)
    }
    
    @objc func resultsButtonTapped() {
        let vc = ResultsViewController()
        present(vc, animated: true)
    }
    
    @objc func addQuestionButtonTapped() {
        let vc = AddQuestionViewController()
        present(vc, animated: true)
    }
}
