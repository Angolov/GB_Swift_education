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
    
    var weathers: List<Weather>!
    let weatherService = WeatherService()
    var cityName = ""
    var token: NotificationToken?
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        weatherService.loadWeatherData(city: cityName)
        pairCollectionAndRealm()
    }
    
    func pairCollectionAndRealm() {
        guard let realm = try? Realm(),
              let city = realm.object(ofType: City.self, forPrimaryKey: cityName)
        else { return }
        
        weathers = city.weathers

        token = weathers.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.weatherCollectionView else { return }
            
            switch changes {
            case .initial:
                collectionView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                collectionView.performBatchUpdates ({
                    collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil )
            
            case .error(let error):
                fatalError("\(error)") }
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
        
        cell.configure(withWeather: weathers[indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension WeatherViewController: UICollectionViewDelegate {
    
}
