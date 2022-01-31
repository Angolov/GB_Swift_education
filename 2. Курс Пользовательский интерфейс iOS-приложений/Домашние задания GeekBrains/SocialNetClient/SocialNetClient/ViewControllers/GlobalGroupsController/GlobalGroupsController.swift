//
//  GlobalGroupsController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit

//MARK: - GlobalGroupsController class declaration
final class GlobalGroupsController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    let reuseIdentifierGroupCell = "reuseIdentifierGroupCell"
    var doAfterGroupSelected: ((GroupProtocol) -> Void)?
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GroupCell", bundle: nil),
                           forCellReuseIdentifier: reuseIdentifierGroupCell)
    }
}
