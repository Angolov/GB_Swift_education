//
//  OrderFromController.swift
//  TSD_lesson7
//
//  Created by Антон Головатый on 30.01.2022.
//

import UIKit

//MARK: - OrderFromController class declaration
final class OrderFromController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productColorLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var applePaySwitch: UISwitch!
    @IBOutlet weak var cashSwitch: UISwitch!
    @IBOutlet weak var applePayButton: UIButton!
    
    var product: ProductProtocol!

    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applePayButton.alpha = 0
        configureView()
    }
    
    //MARK: - Private methods
    private func configureView() {
        if let image = UIImage(named: product.imageNames[0]) {
            productImageView.image = image
        }
        productNameLabel.text = product.name
        productPriceLabel.text = product.priceInUSD
        if let colors = product.colors,
           colors[0] != "" {
            productColorLabel.text = "Color: " + colors[0].lowercased()
        } else {
            productColorLabel.text = ""
        }
        totalPriceLabel.text = product.priceInUSD
    }
    
    //MARK: - Actions
    @IBAction func applePaySwitchChanged(_ sender: Any) {
        if applePaySwitch.isOn {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.cashSwitch.isOn = false
                self.applePayButton.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.applePayButton.alpha = 0
            }
        }
    }
    
    @IBAction func cashSwitchChanged(_ sender: Any) {
        if cashSwitch.isOn {
            applePaySwitch.isOn = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.applePayButton.alpha = 0
            }
        }
    }
    
    @IBAction func proceedButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Are you sure to proceed?",
                                                message: nil,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let proceedAction = UIAlertAction(title: "Ok", style: .default) { _ in
            print("Order placed")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
