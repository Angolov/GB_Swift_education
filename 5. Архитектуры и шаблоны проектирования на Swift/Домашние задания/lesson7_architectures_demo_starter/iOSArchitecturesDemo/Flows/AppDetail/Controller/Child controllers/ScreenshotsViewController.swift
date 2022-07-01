//
//  ScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 24.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class ScreenshotsViewController: UIViewController {
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    // MARK: - Properties
    
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    private var screenshotView:  ScreenshotsView {
        return self.view as!  ScreenshotsView
    }
    
    // MARK: - Init
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = ScreenshotsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenshotView.collectionView.delegate = self
        screenshotView.collectionView.dataSource = self
        screenshotView.collectionView.register(ScreenshotCell.self,
                                               forCellWithReuseIdentifier: Constants.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ScreenshotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier,
                                                              for: indexPath)
        guard let cell = dequeuedCell as? ScreenshotCell,
              let url = URL(string: app.screenshotUrls[indexPath.item]) else {
            return dequeuedCell
        }
        imageDownloader.getImage(fromUrl: url) { image, error in
            cell.screenshotImageView.image = image
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ScreenshotsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ScreenshotPageViewController(app: app, index: indexPath.item)
        
        present(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ScreenshotsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
