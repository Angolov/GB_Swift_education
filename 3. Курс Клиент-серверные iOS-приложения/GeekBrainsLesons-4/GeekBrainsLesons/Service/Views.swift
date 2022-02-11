//
//  Views.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class ViewsControl: UIControl {
    var likesCount: Int = 0
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onClick))
        recognizer.numberOfTapsRequired = 1 // Распознаем кол-во нажатий
        recognizer.numberOfTouchesRequired = 1 // Кол-во пальцев необходимых для реагирования
        
        return recognizer
    }()
    
    private var stackView: UIStackView = UIStackView()
    private var likesImageEmpty: UIImageView = UIImageView()
    private var likesImageFill: UIImageView = UIImageView()
    private var likesLable: UILabel = UILabel()
    private var bgView: UIView = UIView()
    
    private func setupView() {
        // сделаем чтобы наша вью была без фона
        
        self.backgroundColor = .clear
        
        // Зададим нашим image картинку пустого сердца и заполненого
        
        let imageEmpty = UIImage(systemName: "eye")
        likesImageEmpty.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
        likesImageEmpty.image = imageEmpty
        likesImageEmpty.tintColor = .lightGray
        
        let imageFill = UIImage(systemName: "eye.fill")
        likesImageFill.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
        likesImageFill.image = imageFill
        likesImageFill.tintColor = .lightGray
        
        // Настраиваем лейбл
        
        likesLable.frame = CGRect(x: self.frame.size.width - 20, y: 4, width: 10, height: 12)
        likesLable.text = String(likesCount)
        likesLable.textAlignment = .center
        likesLable.textColor = .lightGray
        likesLable.font = UIFont.systemFont(ofSize: 16)
        
        // создадим пустую вью для анимации лайков
        bgView.frame = bounds
        bgView.addSubview(likesImageEmpty)
        bgView.addSubview(likesLable)
        self.addSubview(bgView)
    }
    
    // Создадим метод который меняет кол-во лайков
    
    @objc func onClick() {
        if likesCount == 0 {
            self.likesLable.text = "1"
            likesCount = 1
            
            UIView.transition(from: likesImageEmpty,
                              to: likesImageFill,
                              duration: 0.2,
                              options: .transitionCrossDissolve)
        }else{
            return
        }
        
        likesLable.text = String(likesCount)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
        addGestureRecognizer(tapGestureRecognizer)
    }
}

