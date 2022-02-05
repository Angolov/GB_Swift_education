//
//  PizzaViewController.swift
//  TSD_lesson_9-10
//
//  Created by Антон Головатый on 31.01.2022.
//

import UIKit

//MARK: - PizzaViewController class declaration
final class PizzaViewController: UIViewController {
    
    //MARK: - Private properties
    private let pizzasArray = ["Margarita", "Peperonni"]
    private let pizzaSelectionCellHeight: CGFloat = 155
    private var currentCellPositionY: CGFloat = 80
    
    //MARK: - UI elements
    private var navigationLineView: UIView = {
        var lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.8206655979, green: 0.8152125478, blue: 0.8371365666, alpha: 1)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        return lineView
    }()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 21, weight: .medium, scale: .large)
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward",
                                                           withConfiguration: config),
                                            style: .plain,
                                            target: self,
                                            action: #selector(popViewController(_:)))
        backBarButton.tintColor = UIColor.black
        
        self.navigationItem.title = "Pizza"
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    private func setupView() {
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(navigationLineView)
        navigationLineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 93).isActive = true
        navigationLineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationLineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navigationLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        for i in 0..<pizzasArray.count {
            let newPizzaSelectionView = createPizzaSelectionView(with: i)
            self.view.addSubview(newPizzaSelectionView)
            newPizzaSelectionView.topAnchor.constraint(equalTo: navigationLineView.bottomAnchor,
                                                       constant: currentCellPositionY).isActive = true
            newPizzaSelectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            newPizzaSelectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            newPizzaSelectionView.heightAnchor.constraint(equalToConstant: pizzaSelectionCellHeight).isActive = true
            
            currentCellPositionY += pizzaSelectionCellHeight
        }
    }
    
    private func createPizzaSelectionView(with index: Int) -> UIView {
        let pizzaSelectionView = UIView()
        pizzaSelectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let pizzaImageView = createPizzaImageView(withImage: #imageLiteral(resourceName: "pizza"))
        pizzaSelectionView.addSubview(pizzaImageView)
        pizzaImageView.leadingAnchor.constraint(equalTo: pizzaSelectionView.leadingAnchor,
                                                constant: 20).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: pizzaSelectionView.topAnchor, constant: 5).isActive = true
        pizzaImageView.bottomAnchor.constraint(equalTo: pizzaSelectionView.bottomAnchor,
                                               constant: -10).isActive = true
        pizzaImageView.widthAnchor.constraint(equalTo: pizzaImageView.heightAnchor).isActive = true
        
        let addIngredientsButton = createAddIngredientsButton(with: index)
        pizzaSelectionView.addSubview(addIngredientsButton)
        addIngredientsButton.centerYAnchor.constraint(equalTo: pizzaImageView.centerYAnchor).isActive = true
        addIngredientsButton.trailingAnchor.constraint(equalTo: pizzaSelectionView.trailingAnchor,
                                                       constant: -20).isActive = true
        addIngredientsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addIngredientsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let pizzaNameLabel = createPizzaNameLabel(withText: pizzasArray[index])
        pizzaSelectionView.addSubview(pizzaNameLabel)
        pizzaNameLabel.centerYAnchor.constraint(equalTo: pizzaImageView.centerYAnchor).isActive = true
        pizzaNameLabel.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, constant: 10).isActive = true
        pizzaNameLabel.trailingAnchor.constraint(equalTo: addIngredientsButton.leadingAnchor,
                                                 constant: -10).isActive = true
        
        return pizzaSelectionView
    }
    
    private func createPizzaImageView(withImage image: UIImage) -> UIImageView {
        let pizzaImageView = UIImageView()
        pizzaImageView.image = image
        pizzaImageView.contentMode = .scaleAspectFit
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pizzaImageView
    }
    
    private func createPizzaNameLabel(withText text: String) -> UILabel {
        let pizzaNameLabel = UILabel()
        pizzaNameLabel.text = text
        pizzaNameLabel.font = UIFont .systemFont(ofSize: 28, weight: .medium)
        pizzaNameLabel.textColor = #colorLiteral(red: 0.376470536, green: 0.376470536, blue: 0.376470536, alpha: 1)
        pizzaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pizzaNameLabel
    }
    
    private func createAddIngredientsButton(with index: Int) -> UIButton {
        let addIngredientsButton = UIButton(type: .system)
        addIngredientsButton.backgroundColor = #colorLiteral(red: 1, green: 0.5621066689, blue: 0, alpha: 1)
        addIngredientsButton.layer.cornerRadius = 10
        addIngredientsButton.setTitleColor(.white, for: .normal)
        addIngredientsButton.setTitle("+", for: .normal)
        addIngredientsButton.tag = index
        addIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        addIngredientsButton.addTarget(self,
                                       action: #selector(addIngredientsButtonPressed(_:)),
                                       for: .touchUpInside)
        
        return addIngredientsButton
    }
    
    //MARK: - Actions
    @objc func popViewController(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addIngredientsButtonPressed(_ sender: UIButton) {
        
        let destination = IngredientsViewController()
        destination.pizzaName = pizzasArray[sender.tag]
        present(destination, animated: true, completion: nil)
    }
}
