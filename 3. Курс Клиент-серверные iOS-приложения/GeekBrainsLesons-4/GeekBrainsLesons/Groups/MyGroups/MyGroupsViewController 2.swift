//
//  MyGroupsViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class MyGroupsViewController: UITableViewController {
    
    var myGroups = [GroupModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsViewCell else {
            return UITableViewCell()
        }
        
        let name = myGroups[indexPath.row].name
        let image = myGroups[indexPath.row].image
        
        cell.configure(name: name, image: UIImage(named: image))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // проверяем идентификатор для перехода
        if segue.identifier == "addGroup" {
            // Получаем ссылку на контроллер с которого осуществлен переход
            guard let AllGroupViewController = segue.source as? AllGroupViewController else {
                return
            }
            
            // Получаем название группы и картинку и кладем в мои группы для последущей отрисовки
            if let indexPath = AllGroupViewController.tableView.indexPathForSelectedRow {
                let group = AllGroupViewController.groups[indexPath.row]
                
                    // Если такой группы нет то создаем
                if !myGroups.contains(group) {
                    myGroups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
}
