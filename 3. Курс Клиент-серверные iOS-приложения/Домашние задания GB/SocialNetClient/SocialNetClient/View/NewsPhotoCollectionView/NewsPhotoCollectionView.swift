//
//  NewsPhotoCollectionView.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 14.02.2022.
//

import UIKit

//MARK: - NewsPhotoCollectionView class declaration
final class NewsPhotoCollectionView: UICollectionView {
    
    //MARK: - Private properties
    private var photos: [UIImage]!
    private var photoNames: [String]!
    private var itemSizes: [CGSize]!
    private var completion: (([String], Int) -> Void)?
    
    //MARK: - Initializers
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Public methods
    func configure(with photoNames: [String], completion: (([String], Int) -> Void)?) {
        guard let completion = completion else { return }

        self.dataSource = self
        self.delegate = self
        register(NewsPhotoCell.self, forCellWithReuseIdentifier: NewsPhotoCell.reuseIdentifier)
        self.photoNames = photoNames
        
        photos = [UIImage]()
        for photo in photoNames {
            guard let image = UIImage(named: photo) else { continue }
            photos.append(image)
        }
        self.completion = completion
        getItemSizes()
    }
    
    //MARK: - Private methods
    private func setupView() {
    }
    
    private func getItemSizes() {
        guard photos.count > 0 else { return }
        itemSizes = []
        
        switch photos.count {
        case 1:
            itemSizes.append(CGSize(width: self.bounds.width, height: self.bounds.height))
        case 2:
            itemSizes.append(CGSize(width: self.bounds.width / 2, height: self.bounds.height))
            itemSizes.append(CGSize(width: self.bounds.width / 2, height: self.bounds.height))
        case 3:
            itemSizes.append(CGSize(width: self.bounds.width, height: self.bounds.height / 2))
            itemSizes.append(CGSize(width: self.bounds.width / 2, height: self.bounds.height / 2))
            itemSizes.append(CGSize(width: self.bounds.width / 2, height: self.bounds.height / 2))
        default:
            for _ in 1...4 {
                itemSizes.append(CGSize(width: self.bounds.width / 2, height: self.bounds.height / 2))
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension NewsPhotoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count > 4 ? 4 : photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: NewsPhotoCell.reuseIdentifier,
                                             for: indexPath) as? NewsPhotoCell else { return UICollectionViewCell() }
        var isForthItem = false
        if indexPath.item == 3,
           photos.count > 4 {
            isForthItem = true
        }
        
        cell.configure(with: photos[indexPath.item], isForthItem: isForthItem, counter: photos.count)
        
        return cell
    }
}

extension NewsPhotoCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let completion = completion else { return }
        completion(photoNames, indexPath.item)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension NewsPhotoCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSizes[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
