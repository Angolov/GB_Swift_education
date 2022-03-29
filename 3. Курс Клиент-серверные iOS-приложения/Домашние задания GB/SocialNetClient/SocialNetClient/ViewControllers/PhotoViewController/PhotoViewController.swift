//
//  PhotoViewController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - PhotoViewController class declaration
final class PhotoViewController: UIViewController {

    //MARK: - Properties
    private var images = [UIImage]()
    private var currentIndex = 0
    private var galleryHorizontalView = GalleryHorizontalView()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    //MARK: - Methods
    func configure(imageNames: [String], index: Int) {
        let galleryHorizontalView = GalleryHorizontalView(frame: CGRect(x: 0,
                                                  y: self.view.bounds.height / 2 - self.view.bounds.width / 2,
                                                  width: self.view.bounds.width,
                                                  height: self.view.bounds.width))
        galleryHorizontalView.configure(imageNames: imageNames, index: index)
        self.view.addSubview(galleryHorizontalView)
    }
}
