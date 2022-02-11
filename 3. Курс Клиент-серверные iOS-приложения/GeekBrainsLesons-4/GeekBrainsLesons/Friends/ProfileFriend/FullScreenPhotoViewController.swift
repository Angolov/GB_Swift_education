//
//  FullScreenPhotoViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {

	// Должно приходить от контроллера со всеми фото
	var photos: [UIImage] = []
	var photoViews:[UIImageView] = []

	var selectedPhoto = 0

	// Создаём три переменные, которые будут отвечать за то, что мы видим на экране и с чем взаимодействуем
	private var leftImageView: UIImageView!
	private var middleImageView: UIImageView!
	private var rightImageView: UIImageView!

	// UIViewPropertyAnimator, задаём доступные нам жесты
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

		// создадим вьюхи для отображения
		leftImageView = UIImageView()
		middleImageView = UIImageView()
		rightImageView = UIImageView()
        
        view.addGestureRecognizer(tapPhotoRecognizer)
        view.addGestureRecognizer(exitZoomPhotoRecognizer)
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
		var indexPhotoLeft = selectedPhoto - 1
		let indexPhotoMid = selectedPhoto
		var indexPhotoRight = selectedPhoto + 1

		// делаем круговую прокрутку, чтобы если левый индекс меньше 0, то его ставит последним
		if indexPhotoLeft < 0 {
			indexPhotoLeft = photoViews.count - 1

		}
		if indexPhotoRight > photoViews.count - 1 {
			indexPhotoRight = 0
		}

		// чистим вьюхи, т.к. мы постоянно добавляем новые
		view.subviews.forEach({ $0.removeFromSuperview() })

		// Присваиваем видимым картинкам нужные вьюхи
		leftImageView = photoViews[indexPhotoLeft]
		middleImageView = photoViews[indexPhotoMid]
		rightImageView = photoViews[indexPhotoRight]

		view.addSubview(leftImageView)
		view.addSubview(middleImageView)
		view.addSubview(rightImageView)

		// чистим констрейнты
		leftImageView.translatesAutoresizingMaskIntoConstraints = false
		middleImageView.translatesAutoresizingMaskIntoConstraints = false
		rightImageView.translatesAutoresizingMaskIntoConstraints = false

		// пишем свои
		NSLayoutConstraint.activate([
			middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
			middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 1),
			middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), // выступает на 10 из-за левого края экрана
			leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
			leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

			rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), // выступает на 10 из-за правого края экрана
			rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
			rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
		])

		middleImageView.layer.cornerRadius = 8
		rightImageView.layer.cornerRadius = 8
		leftImageView.layer.cornerRadius = 8

		middleImageView.clipsToBounds = true
		rightImageView.clipsToBounds = true
		leftImageView.clipsToBounds = true

		// изначально уменьшаем картинки, чтобы их потом можно было увеличить, СGAffineTransform имеет св-во .identity и можно вернуть к оригиналу
		let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)

		self.middleImageView.transform = scale
		self.rightImageView.transform = scale
		self.leftImageView.transform = scale

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
                self.leftImageView.transform = .init(scaleX: 0.5, y: 0.5)
			})
	}

	@objc func onPan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			swipeToRight = UIViewPropertyAnimator(
				duration: 0.5,
				curve: .easeInOut,
				animations: {
					UIView.animate(
						withDuration: 0.01,
						animations: { [unowned self] in
							let scale = CGAffineTransform(scaleX: 0.5, y: 0.5) // уменьшаем
							let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 30, y: 0) // направо до края экрана - 30, у нас так констрэйнты заданы
							let transform = scale.concatenating(translation) // объединяем анимации в группу, чтобы задать сразу всем картинкам

                            
							self.middleImageView.transform = transform
							self.rightImageView.transform = transform
							self.leftImageView.transform = transform
						}, completion: { [unowned self] _ in
							self.selectedPhoto -= 1
							if self.selectedPhoto < 0 {
								self.selectedPhoto = self.photos.count - 1
							}
							self.startAnimate()
						})
				})
			swipeToLeft = UIViewPropertyAnimator(
				duration: 0.3,
				curve: .easeInOut,
				animations: {
					UIView.animate(
						withDuration: 0.01,
						animations: { [unowned self] in
							let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
							let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 30, y: 0)
							let transform = scale.concatenating(translation)

							self.middleImageView.transform = transform
							self.rightImageView.transform = transform
							self.leftImageView.transform = transform
						}, completion: { [unowned self] _ in
							self.selectedPhoto += 1
							if self.selectedPhoto > self.photos.count - 1 {
								self.selectedPhoto = 0
							}
							self.startAnimate()
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
            swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }
    
    @objc func zoomAnimatePhoto() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: [],
                       animations: {
            self.middleImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
    }
    @objc func exitZoom() {
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.2,
                                options: [],
                                animations: {
            self.middleImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
    }

    
    lazy var tapPhotoRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(zoomAnimatePhoto))
        recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
        recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
        return recognizer
        
    }()
    
    lazy var exitZoomPhotoRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(exitZoom))
        
        recognizer.numberOfTapsRequired = 2    // Количество нажатий, необходимое для распознавания
        recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
        return recognizer
    }()
}
