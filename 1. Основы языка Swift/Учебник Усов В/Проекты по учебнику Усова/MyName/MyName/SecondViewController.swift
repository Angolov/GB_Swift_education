//
//  SecondViewController.swift
//  MyName
//
//  Created by Антон Головатый on 03.12.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var myLabel: UILabel!
    
    @IBAction func showAlert() {
        
        let alertController = UIAlertController(title: "Welcome",
                                                message: "This is MyName App",
                                                preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        // вывод всплывающего окна
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func changeLabelText(_ sender: UIButton) {
        
        if let buttonText = sender.titleLabel!.text {
                self.myLabel.text = "\(buttonText) button was pressed"
            }
        
    }
    
}
