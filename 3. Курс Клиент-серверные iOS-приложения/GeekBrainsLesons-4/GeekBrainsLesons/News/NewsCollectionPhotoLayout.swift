//
//  NewsCollectionPhotoLayout.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class NewsCollectionPhotoLayuot: UICollectionViewLayout {
   
    // храним атрибуты для индексов
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()

    // кол-во столбцов
    var columnsCount = 2

    // высота ячейки
    var cellHeight: CGFloat = 170

    // сумарная высота ячеек
    private var totalCellsHeight: CGFloat = 0

    override func prepare() {
        //   инициализируем атрибуты
        self.cacheAttributes = [:]
        // проверяем наличие колекшн вью
        guard let collectionView = self.collectionView else {return}
        // проверим что в секции есть ячейки
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else {return}

        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(self.columnsCount)

        var lastY: CGFloat = 0
        var lastX: CGFloat = 0

        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            let isBigCell = (index + 1) % (self.columnsCount + 1) == 0

            // обработаем как буду лежат кортинки, если 3 то большая вверху и 2 в низу если 4 то по 2 в ряд
            if isBigCell && itemsCount != 4 {
                // в атрибутах мы передаем как по факту выглядит ячейка. высота коллекции должна быть задана в сториборде
                attributes.frame = CGRect(x: 0, y: lastY,
                                          width: bigCellWidth, height: self.cellHeight)
                lastY += self.cellHeight
            }else if itemsCount == 1 {
                attributes.frame = CGRect(x: 0, y: 0,
                                          width: bigCellWidth, height: self.collectionView?.frame.height ?? 0)
            }else{
                attributes.frame = CGRect(x: lastX, y: lastY,
                                          width: smallCellWidth, height: self.cellHeight)

                let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
                if isLastColumn {
                    lastX = 0
                    lastY += self.cellHeight
                }else{
                    lastX += smallCellWidth
                }
            }

            // кладем в массив данные о положениях и размерах ячеек
            cacheAttributes[indexPath] = attributes
        }
        self.totalCellsHeight = lastY
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in return rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }
}
