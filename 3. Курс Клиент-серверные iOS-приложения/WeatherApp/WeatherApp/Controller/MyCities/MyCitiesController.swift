//
//  MyCitiesController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit

//MARK: - MyCitiesController class declaration
final class MyCitiesController: UITableViewController {

    //MARK: - Properties
    var cities = [String]()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesCell",
                                                       for: indexPath) as? MyCitiesCell
        else {
            return UITableViewCell()
        }
        
        let city = cities[indexPath.row]
        cell.cityNameLabel.text = city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) }
    }
    
    //MARK: - Actions
    @IBAction func addCity(segue: UIStoryboardSegue) {
        guard segue.identifier == "addCity",
              let allCitiesController = segue.source as? AllCitiesController,
              let indexPath = allCitiesController.tableView.indexPathForSelectedRow else { return }
        
        let city = allCitiesController.cities[indexPath.row].title
        if !cities.contains(city) {
            cities.append(city)
            tableView.reloadData()
        }
    }
}
