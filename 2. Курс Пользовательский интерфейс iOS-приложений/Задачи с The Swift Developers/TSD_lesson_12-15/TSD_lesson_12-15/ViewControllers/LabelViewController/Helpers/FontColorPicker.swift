//
//  FontColorPicker.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 06.02.2022.
//

import UIKit

//MARK: - FontColorPicker class declaration
final class FontColorPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Private properties
    private let fontColors = [UIColor.black, UIColor.red, UIColor.blue]
    private let fontColorsInString = ["Black", "Red", "Blue"]
    
    //MARK: - Public properties
    weak var mainLabel: UILabel!
    
    //MARK: - Public methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontColorsInString.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontColorsInString[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainLabel.textColor = fontColors[row]
    }
}
