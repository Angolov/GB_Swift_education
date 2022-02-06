//
//  LinesCountPicker.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 06.02.2022.
//

import UIKit

//MARK: - LinesCountPicker class declaration
final class LinesCountPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Private properties
    private let linesCount = Array(1...5)
    
    //MARK: - Public properties
    weak var mainLabel: UILabel!
    
    //MARK: - Public methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return linesCount.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(linesCount[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainLabel.numberOfLines = linesCount[row]
    }
}
