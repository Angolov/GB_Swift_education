//
//  GalleryHorizontalView.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 28.01.2022.
//

import UIKit
import SDWebImage

//MARK: - GalleryHorizontalView class declaration

final class GalleryHorizontalView: UIView {
    
    //MARK: - Private properties
    
    @IBInspectable var inactiveIndicatorColor: UIColor = UIColor.lightGray
    @IBInspectable var activeIndicatorColor: UIColor = UIColor.blue
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    var view = UIView()
    var mainImageView = UIImageView()
    var secondaryImageView = UIImageView()
    var images = [UIImage]()
    var imageUrls = [String]()
    var isLeftSwipe = false
    var isRightSwipe = false
    var chooseFlag = false
    var currentIndex = 0
    var customPageView = UIPageControl()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - View setup method
    
    private func setupView() {
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.addGestureRecognizer(recognizer)
        
        mainImageView.backgroundColor = UIColor.clear
        mainImageView.frame = self.bounds
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        self.addSubview(mainImageView)
        
        secondaryImageView.backgroundColor = UIColor.clear
        secondaryImageView.frame = self.bounds
        secondaryImageView.contentMode = .scaleAspectFill
        secondaryImageView.layer.masksToBounds = true
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        self.addSubview(secondaryImageView)
        
        customPageView.backgroundColor = UIColor.clear
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = 1
        customPageView.currentPage = 0
        customPageView.pageIndicatorTintColor = self.inactiveIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        self.addSubview(customPageView)
        
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: customPageView.frame.height).isActive = true
    }
    
    //MARK: - Configure method
    
    func configure(imageNames: [String], index: Int) {
        self.imageUrls = imageNames
        loadImageBy(index: index, isMain: true)
        
        self.currentIndex = index
        customPageView.numberOfPages = self.imageUrls.count
        customPageView.currentPage = index
    }
    
    func loadImageBy(index: Int, isMain: Bool) {
        guard let url = URL(string: imageUrls[index]) else { return }
        
        if isMain {
            self.mainImageView.sd_setImage(with: url, completed: nil)
        } else {
            self.secondaryImageView.sd_setImage(with: url, completed: nil)
        }
    }

}
