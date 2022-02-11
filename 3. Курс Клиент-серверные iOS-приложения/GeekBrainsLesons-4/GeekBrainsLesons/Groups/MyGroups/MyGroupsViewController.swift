//
//  MyGroupsViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

protocol MyGroupDelegate: AnyObject {
    func groupDidSelect(_ group: GroupModel)
}

class MyGroupsViewController: UITableViewController {
    
    var myGroups = [GroupModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
			let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell",
													 for: indexPath) as? MyGroupsViewCell
		else {
            return UITableViewCell()
        }
        
        let name = myGroups[indexPath.row].name
        let image = myGroups[indexPath.row].image
        
        cell.configure(name: name, image: UIImage(named: image))
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
							commit editingStyle: UITableViewCell.EditingStyle,
							forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


// MARK: - addGroupDelegate
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Получаем ссылку на контроллер с которого осуществлен переход
        guard
			let vc = segue.source as? AllGroupViewController
		else {
			return
		}
        vc.delegate = self
        // Получаем название группы и картинку и кладем в мои группы для последущей отрисовки
        if let indexPath = vc.tableView.indexPathForSelectedRow {
            let group = vc.groups[indexPath.row]
            vc.delegate?.groupDidSelect(group)
        }
    }
}

// MARK: - MyGroupDelegate
extension MyGroupsViewController: MyGroupDelegate {
	
    func groupDidSelect(_ group: GroupModel) {
        // Если такой группы нет то добавляем к списку
        if !myGroups.contains(group) {
            myGroups.append(group)
            tableView.reloadData()
        }
    }
}
