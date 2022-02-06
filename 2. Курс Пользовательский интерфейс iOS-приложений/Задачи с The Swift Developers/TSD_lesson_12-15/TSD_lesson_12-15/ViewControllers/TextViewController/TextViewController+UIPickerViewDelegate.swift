//
//  TextViewController+UIPickerViewDelegate.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 06.02.2022.
//

import UIKit

//MARK: - TextViewController extension for UIPickerViewDataSource
extension TextViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
    
    
}
