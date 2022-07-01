//
//  ResultsCell.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import UIKit

//MARK: - ResultsCell class declaration

final class ResultsCell: UITableViewCell {
    
    //MARK: - UI elements
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var resultLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(resultLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(resultLabel)
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        resultLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: self.contentView.width / 3 - 5,
                                 height: self.contentView.height)
        resultLabel.frame = CGRect(x: dateLabel.width + 5,
                                   y: 0,
                                   width: self.contentView.width - dateLabel.width - 10,
                                   height: self.contentView.height)
    }
    
    //MARK: - Methods
    
    func configure(with result: Results) {
        let resultString = "Прогресс: \(result.percentage)%\nВыиграно \(result.money.formatToString()) рублей"
        dateLabel.text = result.date
        resultLabel.text = resultString
    }
}
