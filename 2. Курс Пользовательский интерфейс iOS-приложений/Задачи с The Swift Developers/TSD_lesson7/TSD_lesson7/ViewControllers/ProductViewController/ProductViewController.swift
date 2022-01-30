//
//  ProductViewController.swift
//  TSD_lesson7
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit

//MARK: - ProductViewController class declaration
final class ProductViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var viewImageView: UIView!
    @IBOutlet weak var productImagesView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        viewImageView.layer.cornerRadius = self.view.frame.width / 15
        colorSegmentedControl.isHidden = true
        productDescriptionLabel.isHidden = true
    }

    //MARK: - Public methods
    func configureViewWith(product: ProductProtocol) {
        
        productNameLabel.text = product.name
        productPriceLabel.text = product.priceInUSD
        
        if let image = UIImage(named: product.imageNames[0]) {
            productImagesView.image = image
        }
        
        if product.description != "" {
            productDescriptionLabel.isHidden = false
            productDescriptionLabel.text = product.description
        }
        
        if let colors = product.colors {
            
        }
    }
    
    //MARK: - Actions
    @IBAction func colorChanged(_ sender: UISegmentedControl) {
    }
    
    @IBAction func proceedButtonPressed(_ sender: Any) {
    }
    
}
