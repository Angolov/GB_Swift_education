//
//  PhotoService.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 16.05.2022.
//

import Foundation
import UIKit
import Alamofire

//MARK: - DataReloadable protocol declaration
fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

//MARK: - PhotoService class declaration
final class PhotoService {
    
    //MARK: - Private properties
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                             in: .userDomainMask).first else { return pathName }
        
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    private let container: DataReloadable

    private var images = [String: UIImage]()
    
    //MARK: - Initializers
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    //MARK: - Private methods
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                             in: .userDomainMask).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard let data = response.data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
    
    //MARK: - Public methods
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo } else {
                loadPhoto(atIndexpath: indexPath, byUrl: url) }
        return image
    }
}

//MARK: - PhotoService class extension
extension PhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
