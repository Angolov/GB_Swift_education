//
//  ImageViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class ImageViewController: UIViewController {
    
    // MARK: - UI elements
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Private properties
    
    private let imageDownloader = ImageDownloader()
    private let imageString: String?
    
    // MARK: - Properties
    
    let index: Int
    
    // MARK: - Initializers
    
    init(imageString: String?, index: Int) {
        self.imageString = imageString
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(imageView)
        loadImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.frame
    }
    
    // MARK: - Private methods
    
    private func loadImage() {
        if let imageString = imageString,
           let url = URL(string: imageString) {
            imageDownloader.getImage(fromUrl: url) { [weak self] image, error in
                self?.imageView.image = image
            }
        }
    }
}
