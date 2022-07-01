//
//  AddQuestionViewController.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import UIKit

//MARK: - AddQuestionViewController class declaration

final class AddQuestionViewController: UIViewController {
    
    //MARK: - UI elements
    
    lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Заполните форму"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.tableFooterView = footerView
        return tableView
    }()
    
    lazy var footerView: UIView = {
        var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 52))
        
        var button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        return view
    }()
    
    lazy var addButton: UIButton = {
        var button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    public var counter = 1
    private var userQuestionsBuilder = QuestionsBuilder()
    
    //MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(AddQuestionCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.frame = CGRect(x: 0,
                                   y: 0,
                                   width: self.view.width,
                                   height: 52)
        tableView.frame = CGRect(x: 0,
                                 y: headerLabel.bottom + 5,
                                 width: self.view.width,
                                 height: self.view.height - headerLabel.height - 70)
        addButton.frame = CGRect(x: self.view.width / 3,
                                 y: tableView.bottom + 5,
                                 width: self.view.width / 3,
                                 height: 40)
    }
    
    //MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(headerLabel)
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
    }
    
    private func showAlertWith(title: String, message: String, dismiss: Bool = true) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            if dismiss {
                strongSelf.dismiss(animated: true)
            }
        }))
        present(alert, animated: true)
    }
    
    //MARK: - Actions
    
    @objc func plusButtonTapped() {
        if counter < 3 {
            counter += 1
            tableView.reloadData()
        }
        if counter >= 3 {
            tableView.tableFooterView = nil
        }
    }
    
    @objc func addButtonTapped() {
        var inputIsCorrect = true
        
        for i in 0...counter {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? AddQuestionCell {
                
                if let question = cell.questionTextField.text,
                   let correctAnswer = cell.correctAnswerTextField.text,
                   let wrongAnswers = cell.wrongAnswersTextField.text,
                   wrongAnswers.components(separatedBy: "/").count == 3 {
                    
                    userQuestionsBuilder.addQuestion(question: question)
                    userQuestionsBuilder.addCorrectAnswer(answer: correctAnswer)
                    cell.errorLabel.isHidden = true
                    
                    var answersArray = wrongAnswers.components(separatedBy: "/")
                    answersArray.insert(correctAnswer, at: Int.random(in: 0...2))
                    userQuestionsBuilder.addAnswers(answers: answersArray)
                    
                    userQuestionsBuilder.addGameQuestion()
                }
                else {
                    cell.errorLabel.isHidden = false
                    inputIsCorrect = false
                }
            }
        }
        if inputIsCorrect {
            let questions = userQuestionsBuilder.build()
            Game.shared.addUserQuestions(questions)
            showAlertWith(title: "Спасибо!", message: "Вопрос(ы) добавлен(ы) в игру")
        }
        else {
            userQuestionsBuilder = QuestionsBuilder()
            showAlertWith(title: "Ошибка",
                          message: "Неправильно заполнена форма.\nПопробуйте еще раз",
                          dismiss: false)
        }
    }
}
