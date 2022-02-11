//
//  AllGroupViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 31.10.2021.
//

import UIKit

class AllGroupViewController: UITableViewController {
    
    var groups = GroupArray.iNeedGroups()
    
    // Делегат на добавление группы
    weak var delegate: MyGroupDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as? AllGroupViewCell else {
            return UITableViewCell()
        }
        
        let name = groups[indexPath.row].name
        let image = groups[indexPath.row].image

        cell.nameGroup.text = name
        cell.avatarGroup.image = UIImage(named: image)
		
        return cell
    }
}
