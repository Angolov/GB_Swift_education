//
//  CafeViewController.swift
//  TSD_lesson4
//
//  Created by Антон Головатый on 24.01.2022.
//

import UIKit

class CafeViewController: UIViewController {

    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var tableNumberTextField: UITextField!
    
    let fromCafetoReceiptView = "fromCafetoReceiptView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func makeReceiptButtonPressed(_ sender: Any) {
        
        guard let surname = surnameTextField.text,
              let tableNumber = tableNumberTextField.text else { return }
        
        let alertController = UIAlertController(title: "Proceed with receipt?",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: { [weak self] _ in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromCafetoReceiptView, sender: [surname, tableNumber])
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromCafetoReceiptView,
           let destinationController = segue.destination as? ReceiptViewController,
           let textArray = sender as? [String] {
            destinationController.surname = textArray[0]
            destinationController.tableNumber = textArray[1]
        }
    }
    
}
