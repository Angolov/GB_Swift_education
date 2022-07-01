//
//  AnswerCell.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import UIKit

//MARK: - AnswerCell class declaration

final class AnswerCell: UITableViewCell {
    
    //MARK: - UI elements
    
    lazy var answerLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        self.contentView.addSubview(answerLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        self.contentView.addSubview(answerLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        answerLabel.frame = CGRect(x: 10,
                                   y: 0,
                                   width: self.contentView.width - 20,
                                   height: self.contentView.height)
    }
    
    override func prepareForReuse() {
        answerLabel.text = nil
    }
    
    //MARK: - Methods
    
    func configure(withLiteral literal: String, andAnswer answer: String) {
        answerLabel.text = "\(literal): \(answer)"
    }
}
