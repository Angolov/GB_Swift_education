//
//  MyCitiesController.swift
//  WeatherApp
//
//  Created by Антон Головатый on 12.02.2022.
//

import UIKit
import RealmSwift

//MARK: - MyCitiesController class declaration
final class MyCitiesController: UITableViewController {

    //MARK: - Properties
    var cities: Results<City>?
    var token: NotificationToken?
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pairTableAndRealm()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cities = cities else {
            return 0
        }

        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesCell",
                                                       for: indexPath) as? MyCitiesCell,
              let cities = cities
        else {
            return UITableViewCell()
        }
        
        let city = cities[indexPath.row]
        cell.cityNameLabel.text = city.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let cities = cities else {
            return
        }
        
        let city = cities[indexPath.row]
        
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(city.weathers)
                realm.delete(city)
                try realm.commitWrite()
            }
            catch { print(error)
            }
        }
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        cities = realm.objects(City.self)
        
        guard let cities = cities else {
            return
        }

        token = cities.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                
            case .error(let error):
                fatalError("\(error)") }
        }
    }
    
    func showAddCityForm() {
        let alertController = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in })
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
            guard let name = alertController.textFields?[0].text else { return }
            self?.addCity(name: name)
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addCity(name: String) {
        let newCity = City()
        newCity.name = name
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(newCity, update: .all)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherViewController",
           let cell = sender as? UITableViewCell,
           let cities = cities {
            
            let destination = segue.destination as! WeatherViewController
            if let indexPath = tableView.indexPath(for: cell) {
                destination.cityName = cities[indexPath.row].name
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        showAddCityForm()
    }
}
