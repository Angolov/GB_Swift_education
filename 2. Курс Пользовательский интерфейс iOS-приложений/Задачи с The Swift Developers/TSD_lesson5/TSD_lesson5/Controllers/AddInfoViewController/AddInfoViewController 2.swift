//
//  AddInfoViewController.swift
//  TSD_lesson5
//
//  Created by Антон Головатый on 25.01.2022.
//

import UIKit

//MARK: - BirthdayView class declaration
class AddInfoViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthdayDateTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var sexTextField: UITextField!
    @IBOutlet var instagramTextField: UITextField!
    
    var baseNavigationController: UINavigationController!
    var completion: ((UserBirthdayProtocol) -> Void)?
    
    let ageSelection = Set(1...100)
    let sexSelection = ["Male", "Female"]
    
    var datePicker: UIDatePicker!
    var agePicker: UIPickerView!
    var sexPicker: UIPickerView!
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sexPicker = UIPickerView()
        sexPicker.dataSource = self
        sexPicker.delegate = self
        sexTextField.inputView = sexPicker
    }
    
    //MARK: - Actions
    @IBAction func instagramTextFieldSelected(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter Instagram ID",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Type Instagram ID here..."
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self ]_ in
            guard let self = self,
                  let id = alertController.textFields?[0].text else { return }
            self.instagramTextField.text = id
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func birthdayTextFieldPressed(_ sender: Any) {
        
        datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_US")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        toolbar.setItems([UIBarButtonItem(barButtonSystemItem: .done,
                                          target: nil,
                                          action: #selector(toolbarDoneButtonPressed))],
                         animated: true)
        
        birthdayDateTextField.inputView = datePicker
        birthdayDateTextField.inputAccessoryView = toolbar
    }
    
    @objc func toolbarDoneButtonPressed() {
        
        if datePicker != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            self.birthdayDateTextField.text = dateFormatter.string(from: datePicker.date)
            self.view.endEditing(true)
            return
        }
        
        if agePicker != nil {
            self.view.endEditing(true)
            return
        }
        
        if sexPicker != nil {
            self.view.endEditing(true)
            return
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        guard let nameIsEmpty = nameTextField.text?.isEmpty,
              let birthdayIsEmpty = birthdayDateTextField.text?.isEmpty,
              !nameIsEmpty,
              !birthdayIsEmpty,
              let name = nameTextField.text,
              let birthdayDate = birthdayDateTextField.text else { return }

        let newUser = UserBirthday(name: name, birthDate: birthdayDate, photo: UIImage())
        
        completion?(newUser)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddInfoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sexSelection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sexSelection[row]
    }
    
}

extension AddInfoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTextField.text = sexSelection[row]
        sexTextField.resignFirstResponder()
    }
}
