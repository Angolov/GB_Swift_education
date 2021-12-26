//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Антон Головатый on 24.12.2021.
//

import UIKit

//MARK: - SecondViewController class declaration
class SecondViewController: UIViewController {

    @IBOutlet var dataTextField: UITextField!
    
    var updatingData: String = ""
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Transfer data through property
extension SecondViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
}

//MARK: - Transfer data through segue
extension SecondViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        
        guard let destinationController = segue.destination as? ViewController else { return }
        destinationController.updatedData = dataTextField.text ?? ""
    }
}

//MARK: - Transfer data with delegate
extension SecondViewController {
    
    @IBAction func saveDataWithDelegate (_ sender: UIButton) {
        
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Transfer data with closure
extension SecondViewController {
    
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        
        let updatedData = dataTextField.text ?? ""
        completionHandler?(updatedData)
        navigationController?.popViewController(animated: true)
    }
}
