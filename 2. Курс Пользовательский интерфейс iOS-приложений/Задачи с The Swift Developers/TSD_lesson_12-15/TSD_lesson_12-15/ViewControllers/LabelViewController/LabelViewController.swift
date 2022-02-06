//
//  LabelViewController.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 05.02.2022.
//

import UIKit

//MARK: - LabelViewController class declaration
class LabelViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var fontColorPicker: UIPickerView!
    @IBOutlet weak var linesCountPicker: UIPickerView!
    
    private var fontColorPickerClass = FontColorPicker()
    private var linesCountPickerClass = LinesCountPicker()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        fontColorPicker.delegate = fontColorPickerClass
        fontColorPicker.dataSource = fontColorPickerClass
        
        linesCountPicker.delegate = linesCountPickerClass
        linesCountPicker.dataSource = linesCountPickerClass
    }
    
    //MARK: - Actions
    @IBAction func sizeSliderValueChanged(_ sender: UISlider) {
    }
}

class FontColorPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

class LinesCountPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}
