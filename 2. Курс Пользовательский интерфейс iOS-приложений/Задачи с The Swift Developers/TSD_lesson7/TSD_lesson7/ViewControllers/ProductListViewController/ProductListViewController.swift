//
//  ProductListViewController.swift
//  TSD_lesson7
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit

//MARK: - ProductListViewController class declaration
final class ProductListViewController: UIViewController {

    //MARK: - Private properties
    private var currentProductViewPositionY: CGFloat = 100
    private var products = [ProductProtocol]()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
        createViews(numberOfItemsInRow: 2)
    }
    
    //MARK: - Private methods
    private func loadProducts() {
        products.append(Product(name: "Sentier",
                                colors: nil,
                                description: "Высокие сапоги SENTIER имеют покрытие из пеноматериала в верхней части голенища и на язычке для обеспечения Вашего комфорта.",
                                priceInUSD: "$12.99",
                                imageNames: ["Sentier"]))
        products.append(Product(name: "Crosshunt 100",
                                colors: nil,
                                description: "Эти прочные, водонепроницаемые и простые в уходе ботинки подходят для нерегулярного использования на местности с небольшими неровностями и небольшим количеством агрессивной растительности.",
                                priceInUSD: "$27.99",
                                imageNames: ["Crosshunt 100"]))
        products.append(Product(name: "NH150 MID",
                                colors: ["Light gray", "Blue"],
                                description: "Водонепроницаемые комфортабельные летние ботинки, которые гарантируют хорошее сцепление на любых природных маршрутах с небольшим перепадом высот. Комфортная температура использования - до 10 градусов.",
                                priceInUSD: "$19.99",
                                imageNames: ["NH150 MID-0", "NH150 MID-1"]))
        products.append(Product(name: "SH100 Ultra-Warm",
                                colors: ["Blue", "Dark gray", "Black"],
                                description: "Теплые и водонепроницаемые ботинки с резиновой подошвой Snow Contact обеспечивают оптимальный уровень сцепления и комфорт во время походов по слежавшемуся снегу.",
                                priceInUSD: "$18.79",
                                imageNames: ["SH100 Ultra-Warm-0", "SH100 Ultra-Warm-1", "SH100 Ultra-Warm-2"]))
        products.append(Product(name: "SH100 X-Warm",
                                colors: ["Light gray", "Blue", "Brown"],
                                description: "Походные ботинки или кроссовки, чтобы было удобно во время зимних прогулок? 2 в 1 Благодаря современному дизайну эту модель можно носить как в походе, так и повседневно",
                                priceInUSD: "$39.99",
                                imageNames: ["SH100 X-Warm-0", "SH100 X-Warm-1", "SH100 X-Warm-2"]))
    }
    
    private func createViews(numberOfItemsInRow: CGFloat) {
        let productViewWidth: CGFloat = self.view.frame.width / numberOfItemsInRow
        let productViewHeight: CGFloat = productViewWidth
        var currentProductViewPositionX: CGFloat = 0
        var counter: CGFloat = 1
        
        products.forEach { product in
            let newProductView = ProductView(frame: CGRect(x: currentProductViewPositionX,
                                                           y: currentProductViewPositionY,
                                                           width: productViewWidth,
                                                           height: productViewHeight))
            newProductView.configureViewWith(product: product, and: self)
            self.view.addSubview(newProductView)
            
            if counter < numberOfItemsInRow {
                counter += 1
                currentProductViewPositionX += productViewWidth
            } else {
                counter = 1
                currentProductViewPositionX = 0
                currentProductViewPositionY += productViewHeight
            }
        }
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == fromProductListToProductViewController,
           let destinationController = segue.destination as? ProductViewController,
              let product = sender as? Product else { return }
        
        destinationController.product = product
    }
}
