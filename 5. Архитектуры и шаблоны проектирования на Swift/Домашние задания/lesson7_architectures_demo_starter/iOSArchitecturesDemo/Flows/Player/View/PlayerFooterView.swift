//
//  PlayerFooterView.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 27.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class PlayerFooterView: UIView {
    
    // MARK: - UI elements
    
    private(set) lazy var airplayButton: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(pointSize: 11, weight: .heavy)
        let image = UIImage(systemName: "airplayvideo", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private(set) lazy var devicesLabel: UILabel = {
        let label = UILabel()
        label.text = "Devices available"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addAirplayButton()
        addDevicesLabel()
    }
    
    private func addAirplayButton() {
        self.addSubview(airplayButton)
        
        NSLayoutConstraint.activate([
            airplayButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            airplayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func addDevicesLabel() {
        self.addSubview(devicesLabel)
        
        NSLayoutConstraint.activate([
            devicesLabel.topAnchor.constraint(equalTo: airplayButton.bottomAnchor, constant: 5),
            devicesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
