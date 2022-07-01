//
//  GlobalGroupsController.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import UIKit
import RealmSwift

//MARK: - GlobalGroupsController class declaration

final class GlobalGroupsController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    let adapter = VKServicesAdapter()
    var searchedGroups = [Group]()
    
    lazy var searchBarAnimateClosure: () -> Void = {
        return {
            guard let scopeView = self.searchBar.searchTextField.leftView else { return }
            
            UIView.animate(withDuration: 0.3,
            animations: {
                scopeView.frame = CGRect(x: self.searchBar.frame.width / 2 - 15,
                                         y: scopeView.frame.origin.y,
                                         width: scopeView.frame.width,
                                         height: scopeView.frame.height)
                self.searchBar.layoutSubviews()
            })
        }()
    }
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GroupCell", bundle: nil),
                           forCellReuseIdentifier: GroupCell.reuseIdentifier)
        searchBar.delegate = self
        
        adapter.getSearchedGroups(withQuery: "") { [weak self] groups in
            guard let strongSelf = self else { return }
            strongSelf.searchedGroups = groups
            strongSelf.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBarAnimateClosure()
    }
}
