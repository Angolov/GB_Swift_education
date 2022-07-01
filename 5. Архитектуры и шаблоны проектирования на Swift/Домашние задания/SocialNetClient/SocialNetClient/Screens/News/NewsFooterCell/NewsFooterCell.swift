//
//  NewsFooterCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 05.05.2022.
//

import UIKit

//MARK: - NewsFooterCell class declaration

final class NewsFooterCell: UITableViewCell {

    //MARK: - Type properties
    
    static let reuseIdentifier = "NewsFooterCell"
    
    //MARK: - UI elements
    
    lazy private var likeControlView: LikeControlView = {
        var likeView = LikeControlView()
        likeView.backgroundColor = .blue
        likeView.translatesAutoresizingMaskIntoConstraints = false
        
        return likeView
    }()
    private var commentButton: UIButton = {
        var button = UIButton(type: .custom)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 14)
        button.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        button.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: .normal)
        button.setImage(UIImage(systemName: "text.bubble.fill"), for: .highlighted)
        button.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: .highlighted)
        
        button.tintColor = .lightGray
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var shareButton: UIButton = {
        var button = UIButton(type: .custom)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 14)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: .normal)
        button.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .highlighted)
        button.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: .highlighted)
        
        button.tintColor = .lightGray
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private var viewsButton: UIButton = {
        var button = UIButton(type: .custom)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 14)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .highlighted)
        button.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: .highlighted)
        
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private var viewsLabel: UILabel = {
        var label = UILabel()
        label.font = .mediumRegular
        label.textColor = .lightGray
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
        likeControlView.configure(count: 0, isLiked: false)
        viewsLabel.text = nil
    }
    
    //MARK: - Public properties
    
    func configure(with news: NewsProtocol) {
        
        setupView()
        
        likeControlView.configure(count: news.likes, isLiked: news.isLiked)
        viewsLabel.text = String(news.views)
    }
    
    //MARK: - Private properties
    
    private func setupView() {
        
        self.contentView.addSubview(likeControlView)
        likeControlView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        likeControlView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        likeControlView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        likeControlView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
        self.contentView.addSubview(commentButton)
        commentButton.centerYAnchor.constraint(equalTo: likeControlView.centerYAnchor).isActive = true
        commentButton.leadingAnchor.constraint(equalTo: likeControlView.trailingAnchor).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.contentView.addSubview(shareButton)
        shareButton.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor, constant: -2).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 10).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.contentView.addSubview(viewsButton)
        viewsButton.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor, constant: 2).isActive = true
        viewsButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        viewsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.contentView.addSubview(viewsLabel)
        viewsLabel.centerYAnchor.constraint(equalTo: viewsButton.centerYAnchor).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: viewsButton.leadingAnchor, constant: -5).isActive = true
    }
}

