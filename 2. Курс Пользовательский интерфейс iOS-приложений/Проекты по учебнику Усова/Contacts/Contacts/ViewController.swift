//
//  ViewController.swift
//  Contacts
//
//  Created by Антон Головатый on 23.12.2021.
//

import UIKit

//MARK: - ViewController class declaration
class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var storage: ContactStorageProtocol!
    private var contacts = [ContactProtocol]() {
        didSet {
            contacts.sort{ $0.title < $1.title }
            storage.save(contacts: contacts)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()
    }
    
    private func loadContacts() {
        
        contacts = storage.load()
        
        /*
        contacts.append(Contact(title: "Саня Техосмотр", phone: "+799912312323"))
        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
        contacts.append(Contact(title: "Сильвестр", phone: "+7000911112"))
        */
    }
    
    @IBAction func showNewContactAlert() {
        
        let alertController = UIAlertController(title: "Создайте новый контакт",
                                      message: "Введите имя и телефон",
                                      preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Номер телефона"
        }
        
        let creatButton = UIAlertAction(title: "Создать", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let phoneNumber = alertController.textFields?[1].text else { return }
            
            self.contacts.append(Contact(title: contactName, phone: phoneNumber))
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(creatButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - ViewController extension for UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
            
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}

//MARK: - ViewController extension for UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        
        return actions
    }
}

