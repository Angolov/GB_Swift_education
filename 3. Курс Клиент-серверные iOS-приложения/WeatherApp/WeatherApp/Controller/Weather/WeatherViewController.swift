//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - WeatherViewController class declaration
final class WeatherViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weekDayPicker: WeekDayPicker!
    
    let weatherService = WeatherService()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        weatherService.loadWeatherData(city: "Moscow,RU")
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell",
                                                            for: indexPath) as? WeatherCell
        else {
            return UICollectionViewCell()
        }
        cell.layoutIfNeeded()
        cell.weatherLabel.text = "-10"
        cell.timeLabel.text = "30.08.2017 18:00"
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension WeatherViewController: UICollectionViewDelegate {
    
}
