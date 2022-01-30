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
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    
    //MARK: - Public properties
    var product: ProductProtocol!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureViewWith(product: product)
    }
    
    //MARK: - Private methods
    private func setupView() {
        viewImageView.layer.cornerRadius = self.view.frame.width / 15
        colorSegmentedControl.removeAllSegments()
        colorSegmentedControl.isHidden = true
        productDescriptionTextView.isHidden = true
    }

    //MARK: - Public methods
    func configureViewWith(product: ProductProtocol) {
        
        productNameLabel.text = product.name
        productPriceLabel.text = product.priceInUSD
        
        if let image = UIImage(named: product.imageNames[0]) {
            productImagesView.image = image
        }
        
        if product.description != "" {
            productDescriptionTextView.isHidden = false
            productDescriptionTextView.text = product.description
        }
        
        if let colors = product.colors {
            colorSegmentedControl.isHidden = false
            for index in 0..<colors.count {
                colorSegmentedControl.insertSegment(withTitle: colors[index], at: index, animated: false)
            }
            colorSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == fromProductViewToOrderFormController,
           let destinationController = segue.destination as? OrderFromController,
              let product = sender as? Product else { return }
        
        destinationController.product = product
    }
    
    //MARK: - Actions
    @IBAction func colorChanged(_ sender: UISegmentedControl) {
        guard sender == colorSegmentedControl else { return }
        let index = sender.selectedSegmentIndex
        if let image = UIImage(named: product.imageNames[index]) {
            productImagesView.image = image
        }
    }
    
    @IBAction func proceedButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Are you sure to proceed?",
                                                message: nil,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let proceedAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            var productColors = [""]
            var index = 0
            if let colors = self.product.colors,
               !self.colorSegmentedControl.isHidden {
                productColors = colors
                index = self.colorSegmentedControl.selectedSegmentIndex
            }
            let selectedProduct = Product(name: self.product.name,
                                          colors: [productColors[index]],
                                          description: self.product.description,
                                          priceInUSD: self.product.priceInUSD,
                                          imageNames: [self.product.imageNames[index]])
            
            self.performSegue(withIdentifier: fromProductViewToOrderFormController, sender: selectedProduct)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
