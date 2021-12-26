//
//  ViewController.swift
//  TransferApp
//
//  Created by Антон Головатый on 24.12.2021.
//

import UIKit

//MARK: - ViewController class declaration
class ViewController: UIViewController {

    @IBOutlet var dataLabel: UILabel!
    
    var updatedData: String = "Test data"
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    //MARK: - Private method
    private func updateLabel(withText text: String) {
        
        dataLabel.text = updatedData
    }
}

//MARK: - Transfer data through property
extension ViewController {
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        editScreen.updatingData = dataLabel.text ?? ""
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
}

//MARK: - Transfer data through segue
extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        
        guard let destinationController = segue.destination as? SecondViewController else { return }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
}

//MARK: - Transfer data with delegate
extension ViewController: DataUpdateProtocol {
    
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.handleUpdatedDataDelegate = self
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
}

//MARK: - Transfer data with closure
extension ViewController {
    
    @IBAction func editDataWithСlosure(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        editScreen.updatingData = dataLabel.text ?? ""
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
}



