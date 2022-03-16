//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit
import RealmSwift

//MARK: - WeatherViewController class declaration
final class WeatherViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weekDayPicker: WeekDayPicker!
    
    var weathers = [Weather]()
    let weatherService = WeatherService()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        weatherService.loadWeatherData(city: "Moscow,RU") { [weak self] in
            self?.loadData()
            self?.weatherCollectionView?.reloadData()
        }
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let weathers = realm.objects(Weather.self).filter("city == %@", "Moscow,RU")
            self.weathers = Array(weathers)
        }
        catch {
            print(error)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell",
                                                            for: indexPath) as? WeatherCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(whithWeather: weathers[indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension WeatherViewController: UICollectionViewDelegate {
    
}
