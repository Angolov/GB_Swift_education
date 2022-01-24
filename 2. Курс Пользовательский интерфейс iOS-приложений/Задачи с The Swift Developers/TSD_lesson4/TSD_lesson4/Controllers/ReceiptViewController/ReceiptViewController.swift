//
//  ReceiptViewController.swift
//  TSD_lesson4
//
//  Created by Антон Головатый on 24.01.2022.
//

import UIKit

class ReceiptViewController: UIViewController {

    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var tableNumberLabel: UILabel!
    
    var surname = String()
    var tableNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surnameLabel.text = surname
        tableNumberLabel.text = tableNumber
    }
}
