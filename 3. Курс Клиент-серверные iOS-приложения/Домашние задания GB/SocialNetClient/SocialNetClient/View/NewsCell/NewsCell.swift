//
//  NewsCell.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit

//MARK: - NewsCell class declaration
final class NewsCell: UITableViewCell {

    //MARK: - Type properties
    static let reuseIdentifier = "NewsCell"
    
    //MARK: - UI elements
    lazy private var authorNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    lazy private var photosCollectionView: NewsPhotoCollectionView = {
        return getPhotosCollectionView()
    }()
    lazy private var newsTextView: UITextView = {
        var textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .black
        textView.dataDetectorTypes = .link
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
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
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
        authorNameLabel.text = nil
        authorAvatarView.configure(image: nil)
        dateLabel.text = nil
        newsTextView.text = nil
        likeControlView.configure(count: 0, isLiked: false)
        viewsLabel.text = nil
        photosCollectionView = getPhotosCollectionView()
    }
    
    //MARK: - Public properties
    func configure(with news: NewsProtocol, completion: @escaping ([String], Int) -> Void) {
        
        setupView()
        
        authorNameLabel.text = news.authorName
        authorAvatarView.configure(image: UIImage(named: news.authorAvatarImageName))
        dateLabel.text = news.dateInString
        newsTextView.text = news.text
        likeControlView.configure(count: news.likes, isLiked: news.isLiked)
        viewsLabel.text = String(news.views)
        
        photosCollectionView.configure(with: news.photosNames, completion: completion)
    }
    
    //MARK: - Private properties
    private func setupView() {
        
        self.contentView.addSubview(authorAvatarView)
        authorAvatarView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        authorAvatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        authorAvatarView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        authorAvatarView.widthAnchor.constraint(equalTo: authorAvatarView.heightAnchor).isActive = true
        
        self.contentView.addSubview(authorNameLabel)
        authorNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        authorNameLabel.leadingAnchor.constraint(equalTo: authorAvatarView.trailingAnchor, constant: 10).isActive = true
        authorNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5).isActive = true
        
        self.contentView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true
        
        self.contentView.addSubview(photosCollectionView)
        photosCollectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15).isActive = true
        photosCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        photosCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        photosCollectionView.heightAnchor.constraint(
            equalToConstant: UIConstants.heigthForPhotoCollectionView
        ).isActive = true
        
        self.contentView.addSubview(newsTextView)
        newsTextView.topAnchor.constraint(equalTo: photosCollectionView.bottomAnchor, constant: 5).isActive = true
        newsTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        newsTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        
        self.contentView.addSubview(likeControlView)
        likeControlView.topAnchor.constraint(equalTo: newsTextView.bottomAnchor, constant: 0).isActive = true
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
    
    private func getPhotosCollectionView() -> NewsPhotoCollectionView {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let collectionView = NewsPhotoCollectionView(frame: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: self.frame.width - 10,
                                                                   height: UIConstants.heigthForPhotoCollectionView),
                                                     collectionViewLayout: viewLayout)
        collectionView.setCollectionViewLayout(viewLayout, animated: false)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }

}
