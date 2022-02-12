//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - WeatherViewController class declaration
final class WeatherViewController: UICollectionViewController {

    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell",
                                                            for: indexPath) as? WeatherCell
        else {
            return UICollectionViewCell()
        }
        cell.weatherLabel.text = "30 C"
        cell.timeLabel.text = "30.08.2017 18:00"
        
        return cell
    }
}
