//
//  Product.swift
//  TSD_lesson7
//
//  Created by Антон Головатый on 30.01.2022.
//

//MARK: - ProductProtocol declaration
protocol ProductProtocol {
    
    var name: String { get set }
    var colors: [String]? { get set }
    var description: String { get set }
    var priceInUSD: String { get set }
    var imageNames: [String] { get set }
}

//MARK: - Product struct declaration
struct Product: ProductProtocol {
    
    var name: String
    var colors: [String]?
    var description: String
    var priceInUSD: String
    var imageNames: [String]
}
