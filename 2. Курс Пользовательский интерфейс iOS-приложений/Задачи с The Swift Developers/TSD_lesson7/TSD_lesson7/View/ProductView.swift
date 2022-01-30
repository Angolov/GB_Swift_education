//
//  ProductView.swift
//  TSD_lesson7
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit

//MARK: - ProductView class declaration
final class ProductView: UIView {

    //MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    //MARK: - Private properties
    private var product: ProductProtocol!
    private var view: UIView!
    private weak var viewController: UIViewController!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Private methods
    private func loadFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "ProductView", bundle: bundle)
        guard let view = xib.instantiate(withOwner: self,
                                         options: nil).first as? UIView else { return UIView() }
        return view
    }
    
    private func setupView() {
        self.view = loadFromXib()
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    //MARK: - Public methods
    func configureViewWith(product: ProductProtocol, and viewController: UIViewController) {
        self.product = product
        self.viewController = viewController
        
        productNameLabel.text = product.name
        productPriceLabel.text = product.priceInUSD
        if let image = UIImage(named: product.imageNames[0]) {
            productImageView.image = image
        }
    }
    
    //MARK: - Actions
    @IBAction func productCellButtonPressed(_ sender: UIButton) {
        viewController.performSegue(withIdentifier: fromProductListToProductViewController, sender: product)
    }
}
