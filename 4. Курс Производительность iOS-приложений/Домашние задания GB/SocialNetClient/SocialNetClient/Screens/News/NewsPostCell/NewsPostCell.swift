//
//  NewsPostCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.05.2022.
//

import UIKit

//MARK: - NewsPostCell class declaration
final class NewsPostCell: UITableViewCell {

    //MARK: - Type properties
    static let reuseIdentifier = "NewsPostCell"
    
    //MARK: - UI elements
    lazy private var newsTextLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.textAlignment = .left
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    lazy private var newsReadMoreButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.setTitleColor(UIColor.link, for: .normal)
        button.setTitleColor(UIColor.link, for: .focused)
        let attributedTitle = NSAttributedString(string: readMoreString,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14,
                                                                                       weight: .regular)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setAttributedTitle(attributedTitle, for: .focused)
        button.addTarget(self, action: #selector(readMoreButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let readMoreString = "Read more"
    private let readLessString = "Read less"
    
    private var readMoreState = false
    
    var seeMoreDidTapHandler: (() -> Void)?
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        newsTextLabel.text = nil
        newsTextLabel.numberOfLines = 0
        readMoreState = false
        let attributedTitle = NSAttributedString(string: readMoreString,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14,
                                                                                       weight: .regular)])
        newsReadMoreButton.setAttributedTitle(attributedTitle, for: .normal)
        newsReadMoreButton.setAttributedTitle(attributedTitle, for: .focused)
        newsReadMoreButton.removeFromSuperview()
        newsTextLabel.removeFromSuperview()
    }
    
    //MARK: - Public properties
    func configure(with news: NewsProtocol) {
        
        if news.text.count > 200 {
            newsTextLabel.numberOfLines = 5
            setupViewWithReadMore()
        }
        else {
            newsTextLabel.numberOfLines = 0
            setupView()
        }
        newsTextLabel.text = news.text
    }
    
    //MARK: - Private properties
    private func setupView() {
        
        self.contentView.addSubview(newsTextLabel)
        newsTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        newsTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        newsTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        newsTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setupViewWithReadMore() {
        
        self.contentView.addSubview(newsTextLabel)
        newsTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        newsTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        newsTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        newsTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -40).isActive = true
        
        self.contentView.addSubview(newsReadMoreButton)
        newsReadMoreButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: 5).isActive = true
        newsReadMoreButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        newsReadMoreButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        newsReadMoreButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    @objc func readMoreButtonTapped() {
        
        if !readMoreState {
            let attributedTitle = NSAttributedString(string: readLessString,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 14,
                                                                                           weight: .regular)])
            newsReadMoreButton.setAttributedTitle(attributedTitle, for: .normal)
            newsReadMoreButton.setAttributedTitle(attributedTitle, for: .focused)
            newsTextLabel.numberOfLines = 0
        }
        else {
            let attributedTitle = NSAttributedString(string: readMoreString,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 14,
                                                                                           weight: .regular)])
            newsReadMoreButton.setAttributedTitle(attributedTitle, for: .normal)
            newsReadMoreButton.setAttributedTitle(attributedTitle, for: .focused)
            newsTextLabel.numberOfLines = 5
        }
        seeMoreDidTapHandler?()
        readMoreState.toggle()
    }
}
