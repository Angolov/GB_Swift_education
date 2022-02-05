//
//  CountDownTimerViewController.swift
//  TSD_lesson11
//
//  Created by Антон Головатый on 04.02.2022.
//

import UIKit

class CountDownTimerViewController: UIViewController {

    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var startButtonView: UIView!
    @IBOutlet weak var cancelButtonView: UIView!
    
    let hoursArray = Array(0...23)
    let minutesArray = Array(0...59)
    let secondsArray = Array(0...59)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.delegate = self
        
        setupView()
    }
    
    private func setupView() {
        
        timePicker.setValue(UIColor.white, forKey: "textColor")
        
        startButtonView.backgroundColor = .black
        startButtonView.layer.borderWidth = 2
        startButtonView.layer.borderColor = #colorLiteral(red: 0.0379687883, green: 0.1483575404, blue: 0.06042540818, alpha: 1)
        
        cancelButtonView.backgroundColor = .black
        cancelButtonView.layer.borderWidth = 2
        cancelButtonView.layer.borderColor = #colorLiteral(red: 0.1083275154, green: 0.1083280817, blue: 0.1185227558, alpha: 1)
    }
}

extension CountDownTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hoursArray.count
        case 1: return minutesArray.count
        case 2: return secondsArray.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(hoursArray[row]) ч"
        case 1: return "\(minutesArray[row]) мин"
        case 2: return "\(secondsArray[row]) с"
        default: return nil
        }
    }
}
