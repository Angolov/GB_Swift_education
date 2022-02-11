//
//  FullScreenPhotoViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    // точно передаём номер фото, на которое кликнули
    var indexPath: Int!
    
    // Должно приходить от контроллера со всеми фото
    var photos: [UIImage] = []
    var photoViews:[UIImageView] = []
    
    private var selectedPhoto = 0
    
    // Создаём три переменные, которые будут отвечать за то, что мы видим на экране и с чем взаимодействуем
    
    private var left3ImageView: UIImageView!
    private var left2ImageView: UIImageView!
    private var leftImageView: UIImageView!
    private var middleImageView: UIImageView!
    private var rightImageView: UIImageView!
    private var right2ImageView: UIImageView!
    private var right3ImageView: UIImageView!

    // UIViewPropertyAnimator, задаём доступные нам жесты
    var tapFullScreenPhoto: UIViewPropertyAnimator!
    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!
    
    //  создаём массив вьюх с картинками для галлереи
    func createImageViews() {
        for photo in photos {
            let view = UIImageView()
            view.image = photo
            view.contentMode = .scaleAspectFit
            
            photoViews.append(view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // создаём вьюхи с картинками
        createImageViews()
        selectedPhoto = indexPath
        
        // создадим вьюхи для отображения
        left3ImageView = UIImageView()
        left2ImageView = UIImageView()
        leftImageView = UIImageView()
        middleImageView = UIImageView()
        rightImageView = UIImageView()
        right2ImageView = UIImageView()
        right3ImageView = UIImageView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // регистрируем распознаватель жестов
        let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(gestPan)
        

        
        setImage()
        startAnimate()
    }
    
    // чистим вьюхи, чтобы не накладывались
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.subviews.forEach({ $0.removeFromSuperview() }) // проходится по всем сабвью этой вьюхи и удаляет её из родителя
    }

    // конфигурируем отображение
    func setImage(){
        
        var indexPhotoLeft3 = selectedPhoto - 3
        var indexPhotoLeft2 = selectedPhoto - 2
        var indexPhotoLeft = selectedPhoto - 1
        let indexPhotoMid = selectedPhoto
        var indexPhotoRight = selectedPhoto + 1
        var indexPhotoRight2 = selectedPhoto + 2
        var indexPhotoRight3 = selectedPhoto + 3
        
        

        // делаем круговую прокрутку, чтобы если левый индекс меньше 0, то его ставит последним
        
        
        
        if indexPhotoLeft < 0 {
            indexPhotoLeft = photoViews.count - 1
            indexPhotoLeft2 = photoViews.count - 1
            indexPhotoLeft3 = photoViews.count - 1

        }
        if indexPhotoRight > photoViews.count - 1 {
            indexPhotoRight = 0
            indexPhotoRight2 = 1
            indexPhotoRight3 = 2
        }
        
        
        
        // чистим вьюхи, т.к. мы постоянно добавляем новые
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        // Присваиваем видимым картинкам нужные вьюхи
        
        left3ImageView = photoViews[indexPhotoLeft3]
        left2ImageView = photoViews[indexPhotoLeft2]
        leftImageView = photoViews[indexPhotoLeft]
        middleImageView = photoViews[indexPhotoMid]
        rightImageView = photoViews[indexPhotoRight]
        right2ImageView = photoViews[indexPhotoRight2]
        right3ImageView = photoViews[indexPhotoRight3]
        
        view.addSubview(left3ImageView)
        view.addSubview(left2ImageView)
        view.addSubview(leftImageView)
        view.addSubview(middleImageView)
        view.addSubview(rightImageView)
        view.addSubview(right2ImageView)
        view.addSubview(right3ImageView)

        // чистим констрейнты
        
        left3ImageView.translatesAutoresizingMaskIntoConstraints = false
        left2ImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        right2ImageView.translatesAutoresizingMaskIntoConstraints = false
        right3ImageView.translatesAutoresizingMaskIntoConstraints = false

        // пишем свои
        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 1),
            middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200), // выступает на 200 из-за левого края экрана
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

            rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200), // выступает на 200 из-за правого края экрана
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
            
            left2ImageView.trailingAnchor.constraint(equalTo: leftImageView.leadingAnchor, constant: -30),
            left2ImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            left2ImageView.heightAnchor.constraint(equalTo: leftImageView.heightAnchor),
            left2ImageView.widthAnchor.constraint(equalTo: leftImageView.widthAnchor),
            
            left3ImageView.trailingAnchor.constraint(equalTo: left2ImageView.leadingAnchor, constant: -30),
            left3ImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            left3ImageView.heightAnchor.constraint(equalTo: left2ImageView.heightAnchor),
            left3ImageView.widthAnchor.constraint(equalTo: left2ImageView.widthAnchor),
            
            right2ImageView.leadingAnchor.constraint(equalTo: rightImageView.trailingAnchor, constant: 30),
            right2ImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            right2ImageView.heightAnchor.constraint(equalTo: rightImageView.heightAnchor),
            right2ImageView.widthAnchor.constraint(equalTo: rightImageView.widthAnchor),
            
            right3ImageView.leadingAnchor.constraint(equalTo: right2ImageView.trailingAnchor, constant: 30),
            right3ImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            right3ImageView.heightAnchor.constraint(equalTo: right2ImageView.heightAnchor),
            right3ImageView.widthAnchor.constraint(equalTo: right2ImageView.widthAnchor),
        ])

        middleImageView.layer.cornerRadius = 8
        rightImageView.layer.cornerRadius = 8
        right2ImageView.layer.cornerRadius = 8
        right3ImageView.layer.cornerRadius = 8
        leftImageView.layer.cornerRadius = 8
        left2ImageView.layer.cornerRadius = 8
        left3ImageView.layer.cornerRadius = 8

        middleImageView.clipsToBounds = true
        rightImageView.clipsToBounds = true
        right2ImageView.clipsToBounds = true
        right3ImageView.clipsToBounds = true
        leftImageView.clipsToBounds = true
        left2ImageView.clipsToBounds = true
        left3ImageView.clipsToBounds = true

        // изначально уменьшаем картинки, чтобы их потом можно было увеличить, СGAffineTransform имеет св-во .identity и можно вернуть к оригиналу
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)

        self.middleImageView.transform = scale
        self.rightImageView.transform = scale
        self.right2ImageView.transform = scale
        self.right3ImageView.transform = scale
        self.leftImageView.transform = scale
        self.left2ImageView.transform = scale
        self.left3ImageView.transform = scale

    }

    // тут мы сначала ставим нужные картинки и потом включаем анимацию увеличения до оригинала
    func startAnimate(){
        setImage()
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [],
            animations: { [unowned self] in
                self.middleImageView.transform = .init(scaleX: 0.5, y: 0.5)
                self.rightImageView.transform = .init(scaleX: 0.5, y: 0.5)
                self.right2ImageView.transform = .init(scaleX: 0.5, y: 0.5)
                self.right3ImageView.transform = .init(scaleX: 0.5, y: 0.5)
                self.leftImageView.transform = .init(scaleX: 0.5, y: 0.5)
                self.left2ImageView.transform = .init(scaleX: 0.5, y: 0.5)
                self.left3ImageView.transform = .init(scaleX: 0.5, y: 0.5)
            })
    }

    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(
                duration: 0.3,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: { [unowned self] in
                            let scale = CGAffineTransform(scaleX: 0.5, y: 0.5) // уменьшаем
                            let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 30, y: 0) // направо до края экрана - 30, у нас так констрэйнты заданы
                            let transform = scale.concatenating(translation) // объединяем анимации в группу, чтобы задать сразу всем картинкам
                            
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.right2ImageView.transform = transform
                            self.right3ImageView.transform = transform
                            self.leftImageView.transform = transform
                            self.left2ImageView.transform = transform
                            self.left3ImageView.transform = transform
                            
                        })
                })
            swipeToLeft = UIViewPropertyAnimator(
                duration: 0.3,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: { [unowned self] in
                            let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
                            let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 30, y: 0)
                            let transform = scale.concatenating(translation)
                            
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.right2ImageView.transform = transform
                            self.right3ImageView.transform = transform
                            self.leftImageView.transform = transform
                            self.left2ImageView.transform = transform
                            self.left3ImageView.transform = transform
                            
                        })
                })
        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX)/100 // fractionComplete это про завершенность анимации от 0 до 1, можно плавно делать анимацию в зависимости от жеста
            } else {
                swipeToLeft.fractionComplete = abs(translationX)/100
            }

        case .ended:
            
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 { // если жест это свайп направо
                swipeToRight.fractionComplete = abs(translationX)/100
                if swipeToRight.fractionComplete < 0.5 { // Если анимация не закончена на половину
                    swipeToRight.pauseAnimation() // тормозим анимацию
                    
                    swipeToRight.addAnimations { // возвращаем картинку на место
                        self.middleImageView.transform = .identity
                        self.rightImageView.transform = .identity
                        self.right2ImageView.transform = .identity
                        self.right3ImageView.transform = .identity
                        self.leftImageView.transform = .identity
                        self.left2ImageView.transform = .identity
                        self.left3ImageView.transform = .identity
                        
                    }
                    
                    swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0) // запускаем анимацию
                    return
                }
                
                // по завершению, обновляем индекс выбранной фотки
                self.selectedPhoto -= 1
                if self.selectedPhoto < 0 {
                    self.selectedPhoto = self.photos.count - 1
                }
                
                swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                
            } else { // если налево, то тут тоже самое, но наоборот
                swipeToLeft.fractionComplete = abs(translationX)/100
                if swipeToLeft.fractionComplete < 0.5 {
                    swipeToLeft.pauseAnimation()
                    
                    swipeToLeft.addAnimations {
                        self.middleImageView.transform = .identity
                        self.rightImageView.transform = .identity
                        self.right2ImageView.transform = .identity
                        self.right3ImageView.transform = .identity
                        self.leftImageView.transform = .identity
                        self.left2ImageView.transform = .identity
                        self.left3ImageView.transform = .identity
                    }
                    
                    swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    
                    return
                }
                
                // меняем картинку как выбранную, только если жест окончен
                self.selectedPhoto += 1
                if self.selectedPhoto > self.photos.count - 1 {
                    self.selectedPhoto = 0
                }
                swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
            
            // запускаем анимацию + выставление картинок по концу жеста в любом случае
            self.startAnimate()
            
        default:
            return
        }
    }
}

