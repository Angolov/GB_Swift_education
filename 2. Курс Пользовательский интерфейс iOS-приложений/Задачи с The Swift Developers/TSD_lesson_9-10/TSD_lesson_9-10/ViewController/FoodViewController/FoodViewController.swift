//
//  FoodViewController.swift
//  TSD_lesson_9-10
//
//  Created by Антон Головатый on 31.01.2022.
//

import UIKit

//MARK: - FoodViewController class declaration
final class FoodViewController: UIViewController {

    //MARK: - UI elements
    private var navigationLineView: UIView = {
        var lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.8206655979, green: 0.8152125478, blue: 0.8371365666, alpha: 1)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        return lineView
    }()
    
    private var pizzaButton: UIButton!
    private var sushiButton: UIButton!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupNavigationController() {
        
        self.navigationItem.title = "Food"
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithDefaultBackground()
        appearence.backgroundColor = #colorLiteral(red: 0.9694783092, green: 0.9645436406, blue: 0.9646289945, alpha: 1)
        appearence.titleTextAttributes = [.font: UIFont .systemFont(ofSize: 20, weight: .medium)]
        
        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().compactAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
    }
    
    private func setupView() {
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(navigationLineView)
        navigationLineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 93).isActive = true
        navigationLineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationLineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navigationLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        pizzaButton = createFoodButtonWithTitle(text: "Pizza")
        pizzaButton.addTarget(self, action: #selector(pizzaButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(pizzaButton)
        pizzaButton.topAnchor.constraint(equalTo: navigationLineView.bottomAnchor, constant: 70).isActive = true
        pizzaButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        pizzaButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        pizzaButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        sushiButton = createFoodButtonWithTitle(text: "Sushi")
        self.view.addSubview(sushiButton)
        sushiButton.topAnchor.constraint(equalTo: pizzaButton.bottomAnchor, constant: 30).isActive = true
        sushiButton.leadingAnchor.constraint(equalTo: pizzaButton.leadingAnchor).isActive = true
        sushiButton.trailingAnchor.constraint(equalTo: pizzaButton.trailingAnchor).isActive = true
        sushiButton.heightAnchor.constraint(equalTo: pizzaButton.heightAnchor).isActive = true
    }
    
    private func createFoodButtonWithTitle(text: String) -> UIButton {
        let newFoodButton = UIButton()
        newFoodButton.layer.borderColor = UIColor.black.cgColor
        newFoodButton.layer.borderWidth = 1
        newFoodButton.setTitle(text, for: .normal)
        newFoodButton.setTitleColor(.darkGray, for: .normal)
        newFoodButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        newFoodButton.translatesAutoresizingMaskIntoConstraints = false
        
        return newFoodButton
    }
    
    //MARK: - Actions
    @objc func pizzaButtonPressed(_ sender: UIButton) {
        let destination = PizzaViewController()
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
