//
//  SettingsViewController.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 01.06.2022.
//

import UIKit

//MARK: - SettingsViewController class declaration

final class SettingsViewController: UIViewController {
    
    //MARK: - UI elements
    
    lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var settingsLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Порядок появления вопросов"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        var control = UISegmentedControl(items: ["Последовательно", "Случайно"])
        control.backgroundColor = .brown
        control.selectedSegmentIndex = Game.shared.questionSettings.rawValue
        control.selectedSegmentTintColor = .orange
        control.addTarget(self, action: #selector(segmentedControlValueChange), for: .valueChanged)
        return control
    }()
    
    //MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.04131572694, green: 0.005458934698, blue: 0.4465717077, alpha: 1)
        self.view.addSubview(headerLabel)
        self.view.addSubview(settingsLabel)
        self.view.addSubview(segmentedControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.frame = CGRect(x: 0,
                                   y: 0,
                                   width: self.view.width,
                                   height: 52)
        settingsLabel.frame = CGRect(x: 0,
                                     y: self.view.height / 5 - 60,
                                     width: self.view.width,
                                     height: 52)
        segmentedControl.frame = CGRect(x: 10,
                                        y: self.view.height / 5,
                                        width: self.view.width - 20,
                                        height: 38)
    }
    
    //MARK: - Actions
    
    @objc func segmentedControlValueChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0: Game.shared.questionSettings = .sequential
        case 1: Game.shared.questionSettings = .random
        default:
            return
        }
    }
}
