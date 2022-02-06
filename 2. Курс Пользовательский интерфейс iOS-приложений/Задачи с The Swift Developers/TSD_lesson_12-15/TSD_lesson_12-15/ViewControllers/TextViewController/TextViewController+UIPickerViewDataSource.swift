//
//  TextViewController+UIPickerViewDataSource.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 06.02.2022.
//

import UIKit

//MARK: - TextViewController extension for UIPickerViewDelegate
extension TextViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentFont = fonts[row]
        fontTextField.text = currentFont
        mainTextView.font = UIFont(name: currentFont, size: CGFloat(fontSizeSlider.value))
    }
}
