//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - WeatherCell class declaration
final class WeatherCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            self.shadowView.layer.shadowOffset = .zero
            self.shadowView.layer.shadowOpacity = 0.75
            self.shadowView.layer.shadowRadius = 6
            self.shadowView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.clipsToBounds = true
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH.mm"
        return dateFormatter
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.shadowView.layer.shadowPath = UIBezierPath(ovalIn: self.shadowView.bounds).cgPath
        self.containerView.layer.cornerRadius = self.containerView.frame.width / 2
        
    }
    
    func configure(whithWeather weather: Weather) {
        let date = Date(timeIntervalSince1970: weather.date)
        let stringDate = WeatherCell.dateFormatter.string(from: date)
        timeLabel.text = stringDate
        
        let temp = Int(weather.temp.rounded())
        if temp >= 0 {
            weatherLabel.text = "+\(temp) C"
        } else {
            weatherLabel.text = "\(temp) C"
        }
        
        iconImageView.image = UIImage(named: weather.weatherIcon)
    }
}
