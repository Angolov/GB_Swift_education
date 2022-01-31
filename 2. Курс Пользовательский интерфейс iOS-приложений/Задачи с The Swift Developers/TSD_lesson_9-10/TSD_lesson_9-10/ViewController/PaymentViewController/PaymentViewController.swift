//
//  PaymentViewController.swift
//  TSD_lesson_9-10
//
//  Created by Антон Головатый on 31.01.2022.
//

import UIKit

//MARK: - PaymentViewController class declaration
final class PaymentViewController: UIViewController {
    
    //MARK: - Private properties
    private let productCellHeight: CGFloat = 50
    private var currentPositionY: CGFloat = 35
    
    //MARK: - Public properties
    var selectedProducts: [String]!
    
    //MARK: - UI elements
    private var orderTitleLabel: UILabel = {
        var orderTitleLabel = UILabel()
        orderTitleLabel.text = "Your order:"
        orderTitleLabel.font = .systemFont(ofSize: 32, weight: .medium)
        orderTitleLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        orderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return orderTitleLabel
    }()
    
    private var payByCardLabel: UILabel = {
        var payByCardLabel = UILabel()
        payByCardLabel.text = "Pay by card"
        payByCardLabel.font = .systemFont(ofSize: 32, weight: .medium)
        payByCardLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        payByCardLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return payByCardLabel
    }()
    
    private var payByCardSwitch: UISwitch = {
        var payByCardSwitch = UISwitch()
        payByCardSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        payByCardSwitch.addTarget(self, action: #selector(payByCardSwitchValueChanged(_:)), for: .valueChanged)
        
        return payByCardSwitch
    }()
    
    private var payByCashLabel: UILabel = {
        var payByCashLabel = UILabel()
        payByCashLabel.text = "Pay with cash"
        payByCashLabel.font = .systemFont(ofSize: 32, weight: .medium)
        payByCashLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        payByCashLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return payByCashLabel
    }()
    
    private var payByCashSwitch: UISwitch = {
        var payByCashSwitch = UISwitch()
        payByCashSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        payByCashSwitch.addTarget(self, action: #selector(payByCashSwitchValueChanged(_:)), for: .valueChanged)
        
        return payByCashSwitch
    }()
    
    private var payButton: UIButton = {
        var payButton = UIButton()
        payButton.backgroundColor = #colorLiteral(red: 1, green: 0.5621066689, blue: 0, alpha: 1)
        payButton.setTitle("Proceed", for: .normal)
        payButton.tintColor = .white
        payButton.setTitleColor(.lightGray, for: .highlighted)
        payButton.titleLabel?.font = .systemFont(ofSize: 32, weight: .semibold)
        payButton.layer.cornerRadius = 5
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        payButton.addTarget(self, action: #selector(payButtonPressed(_:)), for: .touchUpInside)
        
        return payButton
    }()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Payment"
        
        self.view.addSubview(orderTitleLabel)
        orderTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 165).isActive = true
        orderTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        orderTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        orderTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        for i in 0..<selectedProducts.count {
            let newProductLabel = createProductLabel(with: i)
            self.view.addSubview(newProductLabel)
            newProductLabel.topAnchor.constraint(equalTo: orderTitleLabel.bottomAnchor,
                                                 constant: currentPositionY).isActive = true
            newProductLabel.leadingAnchor.constraint(equalTo: orderTitleLabel.leadingAnchor).isActive = true
            newProductLabel.trailingAnchor.constraint(equalTo: orderTitleLabel.trailingAnchor).isActive = true
            newProductLabel.heightAnchor.constraint(equalToConstant: productCellHeight).isActive = true
            currentPositionY += productCellHeight
        }
        
        self.view.addSubview(payButton)
        payButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25).isActive = true
        payButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        payButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.view.addSubview(payByCashLabel)
        payByCashLabel.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -40).isActive = true
        payByCashLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        payByCashLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(payByCashSwitch)
        payByCashSwitch.centerYAnchor.constraint(equalTo: payByCashLabel.centerYAnchor).isActive = true
        payByCashSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60).isActive = true
        payByCashSwitch.leadingAnchor.constraint(equalTo: payByCashLabel.trailingAnchor, constant: 10).isActive = true
        
        self.view.addSubview(payByCardLabel)
        payByCardLabel.bottomAnchor.constraint(equalTo: payByCashLabel.topAnchor, constant: -15).isActive = true
        payByCardLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        payByCardLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(payByCardSwitch)
        payByCardSwitch.centerYAnchor.constraint(equalTo: payByCardLabel.centerYAnchor).isActive = true
        payByCardSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60).isActive = true
        payByCardSwitch.leadingAnchor.constraint(equalTo: payByCardLabel.trailingAnchor, constant: 10).isActive = true
    }
    
    private func createProductLabel(with index: Int) -> UILabel {
        let productLabel = UILabel()
        productLabel.text = "\(index + 1)  \(selectedProducts[index])"
        productLabel.font = .systemFont(ofSize: 42, weight: .medium)
        productLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        productLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return productLabel
    }
    
    private func changeButton(_ isProceed: Bool) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.payButton.alpha = 0
        } completion: { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                if isProceed {
                    self.payButton.backgroundColor = #colorLiteral(red: 1, green: 0.5621066689, blue: 0, alpha: 1)
                    self.payButton.setTitle("Proceed", for: .normal)
                    self.payButton.setImage(nil, for: .normal)

                } else {
                    self.payButton.backgroundColor = .black
                    self.payButton.setImage(UIImage(systemName: "applelogo"), for: .normal)
                    let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold)
                    self.payButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
                    self.payButton.setTitle("Pay", for: .normal)
                }
                UIView.animate(withDuration: 0.5) {
                    self.payButton.alpha = 1
                }
            }
        }
    }
    
    //MARK: - Actions
    @objc func payByCardSwitchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            changeButton(!sender.isOn)
            payByCashSwitch.isOn = false
            
        } else {
            changeButton(!sender.isOn)
        }
    }
    
    @objc func payByCashSwitchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            changeButton(sender.isOn)
            payByCardSwitch.isOn = false
            
        } else {
            
        }
    }
    
    @objc func payButtonPressed(_ sender: UIButton) {
        
        let controller = UIAlertController(title: "Payment received!",
                                           message: """
                                           Your order will be delivered in 15 minutes!
                                           Have a nice meal!
                                           """,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            let navController = UINavigationController(rootViewController: FoodViewController())
            navController.modalPresentationStyle = .fullScreen
            navController.modalTransitionStyle = .crossDissolve
            self.present(navController, animated: true, completion: nil)
        }
        
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
}
