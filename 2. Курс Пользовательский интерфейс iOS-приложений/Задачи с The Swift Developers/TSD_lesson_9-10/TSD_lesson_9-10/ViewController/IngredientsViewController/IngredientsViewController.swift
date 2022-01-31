//
//  IngredientsViewController.swift
//  TSD_lesson_9-10
//
//  Created by Антон Головатый on 31.01.2022.
//

import UIKit

class IngredientsViewController: UIViewController {

    //MARK: - Private properties
    private let ingredientsArray = ["Mozarella", "Ham", "Mushrooms", "Olives"]
    private var chosenIngredients = [String]()
    private let ingredientsCellHeight: CGFloat = 55
    private var currentCellPositionY: CGFloat = 30
    
    //MARK: - Public properties
    var pizzaName: String!
    
    //MARK: - UI elements
    var pizzaNameLabel: UILabel = {
        var pizzaNameLabel = UILabel()
        pizzaNameLabel.font = .systemFont(ofSize: 42, weight: .medium)
        pizzaNameLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        pizzaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pizzaNameLabel
    }()
    
    var pizzaImageView: UIImageView = {
        var pizzaImageView = UIImageView()
        pizzaImageView.contentMode = .scaleAspectFit
        pizzaImageView.image = #imageLiteral(resourceName: "pizza")
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pizzaImageView
    }()
    
    var chooseButton: UIButton = {
        var chooseButton = UIButton(type: .system)
        chooseButton.backgroundColor = #colorLiteral(red: 1, green: 0.5621066689, blue: 0, alpha: 1)
        chooseButton.setTitle("Proceed", for: .normal)
        chooseButton.setTitleColor(.white, for: .normal)
        chooseButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        chooseButton.layer.cornerRadius = 10
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.addTarget(self, action: #selector(chooseButtonPressed(_:)), for: .touchUpInside)
        
        return chooseButton
    }()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        
        self.view.backgroundColor = .white
        chosenIngredients.append(pizzaName)
        
        pizzaNameLabel.text = pizzaName
        self.view.addSubview(pizzaNameLabel)
        pizzaNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        pizzaNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(pizzaImageView)
        pizzaImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pizzaImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        pizzaImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                 constant: -40).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: pizzaNameLabel.bottomAnchor, constant: 10).isActive = true
        pizzaImageView.heightAnchor.constraint(equalTo: pizzaImageView.widthAnchor).isActive = true
        
        for i in 0...ingredientsArray.count - 1 {
            let newIngredientCell = createIngredientCell(with: i)
            self.view.addSubview(newIngredientCell)
            newIngredientCell.topAnchor.constraint(equalTo: pizzaImageView.bottomAnchor,
                                                   constant: currentCellPositionY).isActive = true
            newIngredientCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                       constant: 50).isActive = true
            newIngredientCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                        constant: -50).isActive = true
            newIngredientCell.heightAnchor.constraint(equalToConstant: ingredientsCellHeight).isActive = true
            
            currentCellPositionY += ingredientsCellHeight
        }
        
        currentCellPositionY += 30
        
        self.view.addSubview(chooseButton)
        chooseButton.topAnchor.constraint(equalTo: pizzaImageView.bottomAnchor,
                                          constant: currentCellPositionY).isActive = true
        chooseButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        chooseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        chooseButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func createIngredientCell(with index: Int) -> UIView {
        let ingredientsView = UIView()
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        
        let ingredientNameLabel = UILabel()
        ingredientNameLabel.text = ingredientsArray[index]
        ingredientNameLabel.font = UIFont .systemFont(ofSize: 16, weight: .heavy)
        ingredientNameLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        ingredientNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsView.addSubview(ingredientNameLabel)
        ingredientNameLabel.centerYAnchor.constraint(equalTo: ingredientsView.centerYAnchor).isActive = true
        ingredientNameLabel.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor).isActive = true
        
        let ingredientSwitch = UISwitch()
        ingredientSwitch.preferredStyle = .sliding
        ingredientSwitch.tag = index
        ingredientSwitch.translatesAutoresizingMaskIntoConstraints = false
        ingredientSwitch.addTarget(self,
                                   action: #selector(ingredientSwitchValueChanged(_:)),
                                   for: .valueChanged)

        ingredientsView.addSubview(ingredientSwitch)
        ingredientSwitch.centerYAnchor.constraint(equalTo: ingredientsView.centerYAnchor).isActive = true
        ingredientSwitch.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor).isActive = true
        ingredientSwitch.leadingAnchor.constraint(equalTo: ingredientNameLabel.trailingAnchor,
                                                  constant: 20).isActive = true
        
        return ingredientsView
    }
    
    //MARK: - Actions
    @objc func ingredientSwitchValueChanged(_ sender: UISwitch) {
        let index = sender.tag
        let selectedIngredient = ingredientsArray[index]
        
        if sender.isOn,
           !chosenIngredients.contains(selectedIngredient) {
            chosenIngredients.append(selectedIngredient)
            
        } else if !sender.isOn,
                  chosenIngredients.contains(selectedIngredient),
                  let itemIndex = chosenIngredients.firstIndex(of: selectedIngredient) {
            chosenIngredients.remove(at: itemIndex)
        }
    }
    
    @objc func chooseButtonPressed(_ sender: UIButton) {
        let destination = PaymentViewController()
        destination.selectedProducts = chosenIngredients
        
        let navController = UINavigationController(rootViewController: destination)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        present(navController, animated: true, completion: nil)
    }
}
