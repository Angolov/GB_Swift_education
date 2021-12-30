//
//  ViewController.swift
//  TSD_lesson3_1-4
//
//  Created by Антон Головатый on 29.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let initialAlert = UIAlertController(title: "Добро пожаловать!",
                                             message: "Введите свое имя",
                                             preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            self.nameLabel.text = initialAlert.textFields?.first?.text ?? " "
        }
        initialAlert.addTextField { textField in
            textField.placeholder = "Ваше имя"
        }
        initialAlert.addAction(action)
        present(initialAlert, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        
        let newAlert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        newAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(newAlert, animated: true, completion: nil)
    }
    
    @IBAction func sumButtonPressed(_ sender: Any) {
        
        let sumAlert = UIAlertController(title: "Давайте посчитаем сумму",
                                             message: "Введите два числа",
                                             preferredStyle: .alert)
        sumAlert.addTextField { textField in
            textField.placeholder = "Первое число"
        }
        sumAlert.addTextField { textField in
            textField.placeholder = "Второе число"
        }
        
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            var result = 0
            
            if let textOne = sumAlert.textFields?[0].text,
               let textTwo = sumAlert.textFields?[1].text,
               let numOne = Int(textOne),
               let numTwo = Int(textTwo) {
                
                result = numOne + numTwo
                self.showAlert(title: "Давайте посчитаем сумму",
                          message: "Итоговая сумма = \(result)",
                          preferredStyle: .alert)
                
            } else {
                self.showAlert(title: "Давайте посчитаем сумму",
                          message: "Введены неверные данные",
                          preferredStyle: .alert)
            }
        }
        
        sumAlert.addAction(action)
        present(sumAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func guessButtonPressed(_ sender: Any) {
        
        let guessAlert = UIAlertController(title: "Угадай число от 1 до 10",
                                             message: "Введите число",
                                             preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            let guessedNum = Int.random(in: 1...10)
            
            if let textNum = guessAlert.textFields?[0].text,
               let userNum = Int(textNum),
               userNum >= 0,
               userNum <= 10 {
                
                if userNum == guessedNum {
                    self.showAlert(title: "Угадай число от 1 до 10",
                              message: "Вы угадали!\nБыло загадано число \(guessedNum)",
                              preferredStyle: .alert)
                    
                } else {
                    self.showAlert(title: "Угадай число от 1 до 10",
                              message: "Вы не угадали(((\nБыло загадано число \(guessedNum)",
                              preferredStyle: .alert)
                }
            } else {
                self.showAlert(title: "Угадай число от 1 до 10",
                          message: "Введены неверные данные",
                          preferredStyle: .alert)
            }
        }
        guessAlert.addTextField { textField in
            textField.placeholder = "Число от 1 до 10"
        }
        guessAlert.addAction(action)
        present(guessAlert, animated: true, completion: nil)
    }
    
}

