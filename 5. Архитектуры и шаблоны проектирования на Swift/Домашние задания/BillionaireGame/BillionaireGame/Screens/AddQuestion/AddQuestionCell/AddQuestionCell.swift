//
//  AddQuestionCell.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import UIKit

//MARK: - AddQuestionCell class declaration

final class AddQuestionCell: UITableViewCell {
    
    //MARK: - UI elements
    
    lazy var questionLabel: UILabel = {
        var label = UILabel()
        label.text = "Вопрос"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var questionTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var correctAnswerLabel: UILabel = {
        var label = UILabel()
        label.text = "Правильный ответ"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var correctAnswerTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var wrongAnswersLabel: UILabel = {
        var label = UILabel()
        label.text = "Неправильные ответы (через '/')"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var wrongAnswersTextField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.text = "Неправильно заполнена форма"
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let widthSize = self.contentView.width - 10
        let heightSize = CGFloat(32)
        let inset = CGFloat(5)
        
        errorLabel.frame = CGRect(x: 0,
                                  y: 0,
                                  width: widthSize,
                                  height: 10)
        questionLabel.frame = CGRect(x: inset,
                                     y: errorLabel.bottom + 1,
                                     width: widthSize,
                                     height: heightSize)
        questionTextField.frame = CGRect(x: inset,
                                         y: questionLabel.bottom + inset,
                                         width: widthSize,
                                         height: heightSize)
        correctAnswerLabel.frame = CGRect(x: inset,
                                          y: questionTextField.bottom + inset,
                                          width: widthSize,
                                          height: heightSize)
        correctAnswerTextField.frame = CGRect(x: inset,
                                              y: correctAnswerLabel.bottom + inset,
                                              width: widthSize,
                                              height: heightSize)
        wrongAnswersLabel.frame = CGRect(x: inset,
                                         y: correctAnswerTextField.bottom + inset,
                                         width: widthSize,
                                         height: heightSize)
        wrongAnswersTextField.frame = CGRect(x: inset,
                                             y: wrongAnswersLabel.bottom + inset,
                                             width: widthSize,
                                             height: heightSize)
    }
    
    //MARK: - Methods
    
    private func setupView() {
        self.contentView.addSubview(errorLabel)
        self.contentView.addSubview(questionLabel)
        self.contentView.addSubview(questionTextField)
        self.contentView.addSubview(correctAnswerLabel)
        self.contentView.addSubview(correctAnswerTextField)
        self.contentView.addSubview(wrongAnswersLabel)
        self.contentView.addSubview(wrongAnswersTextField)
    }
}
