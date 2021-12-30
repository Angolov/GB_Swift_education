//
//  ViewController.swift
//  TSD_lesson3_5-6
//
//  Created by Антон Головатый on 30.12.2021.
//

import UIKit

class ViewController: UIViewController {

    var helloClass: HelloProtocol!
    
    @IBOutlet var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloClass = Hello()
    }

    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Преобразователь",
                                      message: "Введите слово",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Слово..."
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if let text = alert.textFields?[0].text,
               let resultText = self.helloClass.helloTransformFrom(text) {
                self.helloLabel.text = resultText
                
            } else {
                self.helloLabel.text = "wrong input"
            }
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

