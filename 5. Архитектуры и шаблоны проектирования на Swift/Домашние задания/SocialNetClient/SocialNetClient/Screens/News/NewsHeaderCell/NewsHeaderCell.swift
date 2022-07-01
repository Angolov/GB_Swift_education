//
//  NewsHeaderCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.05.2022.
//

import UIKit

//MARK: - NewsHeaderCell class declaration

final class NewsHeaderCell: UITableViewCell {

    //MARK: - Type properties
    
    static let reuseIdentifier = "NewsHeaderCell"
    
    //MARK: - UI elements
    
    lazy private var authorNameLabel: UILabel = {
        var label = UILabel()
        label.font = .bigSemibold
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    lazy private var authorAvatarView: AvatarView = {
        var avatar = AvatarView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        return avatar
    }()
    lazy private var dateLabel: UILabel = {
        var label = UILabel()
        label.font = .mediumRegular
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        authorNameLabel.text = nil
        authorAvatarView.configure(image: nil)
        dateLabel.text = nil
    }
    
    //MARK: - Public properties
    
    func configure(with news: NewsProtocol) {
        
        setupView()
        
        authorNameLabel.text = news.authorName
        if let url = URL(string: news.authorAvatarImageName) {
            authorAvatarView.configure(url: url)
        }
        dateLabel.text = news.dateInString
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        
        self.contentView.addSubview(authorAvatarView)
        authorAvatarView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        authorAvatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        authorAvatarView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        authorAvatarView.widthAnchor.constraint(equalTo: authorAvatarView.heightAnchor).isActive = true
        authorAvatarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
        self.contentView.addSubview(authorNameLabel)
        authorNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        authorNameLabel.leadingAnchor.constraint(equalTo: authorAvatarView.trailingAnchor, constant: 10).isActive = true
        authorNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5).isActive = true
        
        self.contentView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true
    }
}
