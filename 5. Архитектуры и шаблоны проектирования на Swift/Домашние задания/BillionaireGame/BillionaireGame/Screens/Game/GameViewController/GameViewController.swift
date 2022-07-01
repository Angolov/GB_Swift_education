//
//  GameViewController.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 27.05.2022.
//

import UIKit

//MARK: - GameViewController class declaration

final class GameViewController: UIViewController {

    //MARK: - UI elements
    
    lazy var headerView: HeaderView = {
        var headerView = HeaderView()
        headerView.backgroundColor = .gray
        return headerView
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    lazy var fiftyHelpButton: UIButton = {
        var button = UIButton()
        let title = NSAttributedString(string: "50:50", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .bold)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        button.addTarget(self, action: #selector(fiftyHelpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var viewersHelpButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "person.3.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        button.addTarget(self, action: #selector(viewersHelpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var friendHelpButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        button.addTarget(self, action: #selector(friendHelpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    let charIndex = ["A", "B", "C", "D"]
    var session: GameSession!
    var currentQuestion: Question!
    
    //MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fiftyHelpButton.frame = CGRect(x: 0,
                                       y: self.view.bottom - 65,
                                       width: self.view.width / 3,
                                       height: 52)
        viewersHelpButton.frame = CGRect(x: fiftyHelpButton.right,
                                         y: self.view.bottom - 65,
                                         width: self.view.width / 3,
                                         height: 52)
        friendHelpButton.frame = CGRect(x: viewersHelpButton.right,
                                        y: self.view.bottom - 65,
                                        width: self.view.width / 3,
                                        height: 52)
        let tableViewHeight = self.view.height / 4
        tableView.frame = CGRect(x: 0,
                                 y: fiftyHelpButton.top - tableViewHeight,
                                 width: self.view.width,
                                 height: tableViewHeight)
        headerView.frame = CGRect(x: 0,
                                  y: self.view.safeAreaInsets.top,
                                  width: self.view.width,
                                  height: tableView.top - self.view.safeAreaInsets.top)
    }
    
    //MARK: - Methods
    
    private func setupView() {
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.view.addSubview(fiftyHelpButton)
        self.view.addSubview(viewersHelpButton)
        self.view.addSubview(friendHelpButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(AnswerCell.self)
    }
    
    private func configure() {
        currentQuestion = session.questionStrategy.getQuestion(for: session)
        session.hintUsageFacade.currentQuestion = currentQuestion
        
        headerView.configure(currentSum: session.currentMoney,
                             question: currentQuestion.question)
        
        session.index.addObserver(self, options: [.new]) { [weak self] index, _ in
            guard let strongSelf = self else { return }
            let percentage = Double(strongSelf.session.index.value) / Double(strongSelf.session.questionsCount) * 100
            strongSelf.headerView.questionNumberLabel.text = "Вопрос \(index + 1). Текущий прогресс: \(percentage.formatToString()) %"
        }
    }
    
    //MARK: - Actions
    
    @objc func fiftyHelpButtonTapped() {
        guard session.fiftyHelpAvailable else { return }
        session.fiftyHelpAvailable.toggle()
        currentQuestion = session.hintUsageFacade.use50to50Hint()
        tableView.reloadData()
        
        fiftyHelpButton.setTitleColor(.lightGray, for: .normal)
        fiftyHelpButton.isEnabled.toggle()
    }
    
    @objc func viewersHelpButtonTapped() {
        guard session.viewersHelpAvailable else { return }
        session.viewersHelpAvailable.toggle()
        let result = session.hintUsageFacade.useAuditoryHelp()
        
        let alert = UIAlertController(title: "Результат зрительского голосования:",
                                      message: result,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

        viewersHelpButton.tintColor = .lightGray
        viewersHelpButton.isEnabled.toggle()
    }
    
    @objc func friendHelpButtonTapped() {
        guard session.friendHelpAvailable else { return }
        session.friendHelpAvailable.toggle()
        let result = session.hintUsageFacade.callFriend()
        
        let alert = UIAlertController(title: "Совет друга",
                                      message: result,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        friendHelpButton.tintColor = .lightGray
        friendHelpButton.isEnabled.toggle()
    }
}
