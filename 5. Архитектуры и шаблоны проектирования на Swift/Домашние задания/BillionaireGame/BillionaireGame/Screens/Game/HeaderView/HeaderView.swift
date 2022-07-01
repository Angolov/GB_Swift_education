//
//  HeaderView.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 29.05.2022.
//

import UIKit

//MARK: - HeaderView class declaration

final class HeaderView: UIView {
    
    //MARK: - UI elements
    
    lazy var questionNumberLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        label.textAlignment = .center
        label.text = "Вопрос 1. Текущий прогресс: 0 %"
        return label
    }()
    
    lazy var currentSumLabel: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0.9036857486, green: 0.6730598807, blue: 0.1417288482, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "gameLogo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var questionLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.borderWidth = 5
        label.layer.cornerRadius = 10
        let borderColor = #colorLiteral(red: 0.3983691335, green: 0.5167264342, blue: 0.7599620223, alpha: 1)
        label.layer.borderColor = borderColor.cgColor
        return label
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        questionLabel.frame = CGRect(x: 0,
                               y: self.height - 104,
                               width: self.width,
                               height: 104)
        questionNumberLabel.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.width,
                                     height: 52)
        currentSumLabel.frame = CGRect(x: 0,
                                 y: questionNumberLabel.bottom,
                                 width: self.width,
                                 height: 52)
        logoImageView.frame = CGRect(x: 0,
                                     y: currentSumLabel.bottom,
                                     width: self.width,
                                     height: questionLabel.top - currentSumLabel.bottom)
    }
    
    func configure(currentSum: Int, question: String) {
        currentSumLabel.text = "\(currentSum.formatToString()) рублей"
        questionLabel.text = question
    }
    
    private func setupView() {
        self.addSubview(questionNumberLabel)
        self.addSubview(currentSumLabel)
        self.addSubview(questionLabel)
        self.addSubview(logoImageView)
    }
}
