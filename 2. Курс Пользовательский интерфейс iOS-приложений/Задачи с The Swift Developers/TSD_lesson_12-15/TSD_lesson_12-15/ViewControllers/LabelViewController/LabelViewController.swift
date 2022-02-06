//
//  LabelViewController.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 05.02.2022.
//

import UIKit

//MARK: - LabelViewController class declaration
final class LabelViewController: UIViewController {

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
        mainLabel.font = .systemFont(ofSize: 17, weight: .bold)
        mainLabel.text = "This is a lesson 12 homework from The Swift Developers UIKit course."
        
        sizeSlider.minimumValue = 8
        sizeSlider.maximumValue = 50
        sizeSlider.setValue(17, animated: false)
        
        fontColorPickerClass.mainLabel = mainLabel
        fontColorPicker.delegate = fontColorPickerClass
        fontColorPicker.dataSource = fontColorPickerClass
        
        linesCountPickerClass.mainLabel = mainLabel
        linesCountPicker.delegate = linesCountPickerClass
        linesCountPicker.dataSource = linesCountPickerClass
    }
    
    //MARK: - Actions
    @IBAction func sizeSliderValueChanged(_ sender: UISlider) {
        mainLabel.font = .systemFont(ofSize: CGFloat(sender.value), weight: .bold)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Enter text for label", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let textField = alert.textFields?[0],
                  let text = textField.text,
                  let self = self else {return}
            
            self.mainLabel.text = text
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
