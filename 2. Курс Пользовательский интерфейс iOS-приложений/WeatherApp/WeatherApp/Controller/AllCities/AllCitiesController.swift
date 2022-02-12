//
//  AllCitiesController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - AllCitiesController class declaration
final class AllCitiesController: UITableViewController {

    //MARK: - Properties
    var cities = [
        "Moscow",
        "Krasnoyarsk",
        "London",
        "Paris"
    ]
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell",
                                                       for: indexPath) as? AllCitiesCell
        else {
            return UITableViewCell()
        }
        
        let city = cities[indexPath.row]
        cell.cityNameLabel.text = city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
