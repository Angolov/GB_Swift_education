//
//  LikeControlView.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 28.01.2022.
//

import UIKit

//MARK: - LikeControlView class declaration
class LikeControlView: UIView {
    
    //MARK: - Private properties
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var heartButon: UIButton!
    
    private var view: UIView!
    
    private var isHeartEmpty = true
    private var isLiked = false
    private var currentLikeCount = 0
    private var doAfterLike: ((Int, Bool) -> Void)?
    
    private let emptyHeart = "heart"
    private let fullHeart = "heart.fill"
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func loadFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "LikeControlView", bundle: bundle)
        guard let view = xib.instantiate(withOwner: self,
                                         options: nil).first as? UIView else { return UIView() }
        return view
    }
    
    //MARK: - View setup method
    private func setupView() {
        view = loadFromXib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.view)
    }
    
    //MARK: - Public methods
    func configure(count: Int, isLiked: Bool, completion: @escaping (Int, Bool) -> Void) {
        currentLikeCount = count
        counterLabel.text = String(currentLikeCount)
        doAfterLike = completion
        self.isLiked = isLiked
        isHeartEmpty = !isLiked
        
        if isLiked {
            heartButon.setImage(UIImage(systemName: fullHeart), for: .normal)
        } else {
            heartButon.setImage(UIImage(systemName: emptyHeart), for: .normal)
        }
    }
    
    //MARK: - Actions
    @IBAction func liked(_ sender: Any) {
        
        if isHeartEmpty {
            currentLikeCount += 1
            heartButon.setImage(UIImage(systemName: fullHeart), for: .normal)
            isLiked = true
            
        } else {
            guard currentLikeCount > 0 else { return }
            currentLikeCount -= 1
            heartButon.setImage(UIImage(systemName: emptyHeart), for: .normal)
            isLiked = false
        }
        
        if let completion = doAfterLike {
            completion(currentLikeCount, isLiked)
        }
        
        UIView.transition(with: counterLabel,
                          duration: 0.5,
                          options: .transitionFlipFromTop) { [weak self] in
            guard let self = self else { return }
            self.counterLabel.text = String(self.currentLikeCount)
        } completion: { _ in }
        
        isHeartEmpty = !isHeartEmpty
    }
}
