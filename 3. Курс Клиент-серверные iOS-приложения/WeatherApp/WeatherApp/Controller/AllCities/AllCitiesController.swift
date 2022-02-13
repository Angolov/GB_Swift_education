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
        (title: "Moscow", emblem: #imageLiteral(resourceName: "moscow")),
        (title: "Krasnoyarsk", emblem: #imageLiteral(resourceName: "krasnoyarsk")),
        (title: "London", emblem: #imageLiteral(resourceName: "london")),
        (title: "Paris", emblem: #imageLiteral(resourceName: "paris")),
        (title: "Novosibirsk", emblem: #imageLiteral(resourceName: "novosibirsk"))
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
        cell.configure(city: city.title, emblem: city.emblem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
