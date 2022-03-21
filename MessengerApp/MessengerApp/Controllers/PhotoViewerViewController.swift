//
//  PhotoViewerViewController.swift
//  MessengerApp
//
//  Created by Антон Головатый on 25.02.2022.
//

import UIKit
import SDWebImage

//MARK: - PhotoViewerViewController class declaration
final class PhotoViewerViewController: UIViewController {

    //MARK: - UI elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //MARK: - Properties
    private let url: URL

    //MARK: - Initializers
    init(with url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .black
        imageView.frame = view.bounds
    }
    
    //MARK: - Private methods
    private func setupView() {
        title = "Photo"
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(imageView)
        imageView.sd_setImage(with: url, completed: nil)
    }
}
