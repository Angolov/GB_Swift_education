//
//  TextViewController.swift
//  TSD_lesson_12-15
//
//  Created by Антон Головатый on 05.02.2022.
//

import UIKit

//MARK: - TextViewController class declaration
class TextViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontTextField: UITextField!
    @IBOutlet weak var mainTextView: UITextView!
    
    //MARK: - Private properties
    private let fonts = ["Arial", "Bradley Hand Bold", "Futura Medium", "Noteworthy Bold"]
    private var fontPicker = UIPickerView()
    private var currentFont = ""
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private methods
    private func setupView() {
        
        fontPicker.delegate = self
        fontPicker.dataSource = self
        
        fontSizeSlider.minimumValue = 8
        fontSizeSlider.maximumValue = 30
        fontSizeSlider.setValue(17, animated: false)
        
        fontTextField.text = "Select font here"
        fontTextField.textAlignment = .center
        fontTextField.inputView = fontPicker
        
        mainTextView.font = .systemFont(ofSize: 17)
        mainTextView.backgroundColor = .clear
    }
    
    //MARK: - Actions
    
    @IBAction func fontSizeSliderValueChanged(_ sender: UISlider) {
        
        if currentFont == "" {
            mainTextView.font = .systemFont(ofSize: CGFloat(sender.value))
        } else {
            mainTextView.font = UIFont(name: currentFont, size: CGFloat(sender.value))
        }
    }
    
    @IBAction func blackButtonPressed(_ sender: UIButton) {
        mainTextView.textColor = .black
    }
    
    @IBAction func tealButtonPressed(_ sender: UIButton) {
        mainTextView.textColor = .systemTeal
    }
    
    @IBAction func redButtonPressed(_ sender: UIButton) {
        mainTextView.textColor = .systemRed
    }
    
    @IBAction func yellowButtonPressed(_ sender: UIButton) {
        mainTextView.textColor = .systemYellow
    }
    
    @IBAction func fontSmallWeightButtonPressed(_ sender: UIButton) {
        mainTextView.font = .systemFont(ofSize: CGFloat(fontSizeSlider.value), weight: .regular)
    }
    
    @IBAction func fontBigWeightButtonPressed(_ sender: UIButton) {
        mainTextView.font = .systemFont(ofSize: CGFloat(fontSizeSlider.value), weight: .bold)
    }
    
    @IBAction func darkModeSwitchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            self.view.backgroundColor = .darkGray
        } else {
            self.view.backgroundColor = .white
        }
    }
    
}
