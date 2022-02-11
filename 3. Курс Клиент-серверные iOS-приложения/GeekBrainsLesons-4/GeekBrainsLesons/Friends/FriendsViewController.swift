//
//  FriendsViewController.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class FriendsViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cellsForAnimate: [FriendsViewCell] = []
    
    var friends = FriendsArray.iNeedFriends()
    var lettersOfNames = [String]()
    lazy var filteredFriend = friends
    
    func searchBarAnimateClosure () -> () -> Void {
        return {
            guard let scopeView = self.searchBar.searchTextField.leftView else {return}
            guard let placeholderLabel = self.searchBar.textField?.value(forKey: "placeholderLabel") as? UILabel else {return}
            
            UIView.animate(withDuration: 0.3,
            animations: {
                scopeView.frame = CGRect(x: self.searchBar.frame.width / 2 - 15, y: scopeView.frame.origin.y, width: scopeView.frame.width, height: scopeView.frame.height)
                placeholderLabel.frame.origin.x -= 20
                self.searchBar.layoutSubviews()
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        searchBar.delegate = self
        loadLetters()
    }
    
    // настройка поискБара
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            UIView.animate(withDuration: 0, animations: self.searchBarAnimateClosure())
        })
    }
    
    // Создадим массив для заголовков секций
    func loadLetters() {
        for friend in friends {
            lettersOfNames.append(String(friend.key))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriend.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriend[section].data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = friends[section]
        
        return String(section.key)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsViewCell else {
            return UITableViewCell()
        }
        
        let section = filteredFriend[indexPath.section]
        let name = section.data[indexPath.row].name
        let image = section.data[indexPath.row].image
        
        cell.configure(name: name, image: UIImage(named: image)!)
        
        cellsForAnimate.append(cell)
        return cell
    }
    
    // создадим массив имен секций, по букве с которой начинаются именя друзей
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersOfNames
    }
    
    // настроим хедер ячеек и добавим в него буквы
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // создадим вью заголовка
        let header = UIView()
        header.backgroundColor = .lightGray.withAlphaComponent(0.5) // задний фон
        
        let leter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        leter.textColor = UIColor.black.withAlphaComponent(0.5) // прозрачность надписи
        leter.text = String(filteredFriend[section].key) // в зависимости от номера секции задаем ей разные именя из масива
        leter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light) // Шрифт
        header.addSubview(leter)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsViewCell {
            cell.animate()
        }
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsViewCell {
            cell.animate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProfileFriendViewController {
            guard let vc = segue.destination as? ProfileFriendViewController else {
                return
            }
            guard let indexPathSection = tableView.indexPathForSelectedRow?.section else {
                return
            }
            guard let indexPathRow = tableView.indexPathForSelectedRow?.row else {
                return
            }
            
            let section = filteredFriend[indexPathSection]
            vc.friend = section.data[indexPathRow]
        }
    }
}

// MARK: UISearchBarDelegate

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // очистим массив для повторяющегося поиска
        filteredFriend = []
        
        // если поле поиска пусто то ничего фильтровать и не надо
        if searchText == "" {
            filteredFriend = friends
        }else{
            for section in friends { // перебираем массив секций с друзьями
                for (_, friend) in section.data.enumerated() { // потом перебираем массивы друзей в секциях
                    if friend.name.lowercased().contains(searchText.lowercased()) { // Ищем в имени нужный текст, оба текста сравниваем в нижнем регистре
                        var searchedSection = section
                        
                        // Если фильтр пустой, то можно сразу добавить
                        if filteredFriend.isEmpty {
                            searchedSection.data = [friend]
                            filteredFriend.append(searchedSection)
                            break
                        }
                        // Если в массиве секции уже есть секция с таким ключом, то нужно к имеющемуся массиву друзей добавить друга
                        var found = false
                        for (sectionIndex, filteredSection) in filteredFriend.enumerated() {
                            if filteredSection.key == section.key {
                                filteredFriend[sectionIndex].data.append(friend)
                                found = true
                                break
                            }
                        }
                        // Если ключа еще нет, то создается новый массив с нашим найденным другом
                        if !found {
                            searchedSection.data = [friend]
                            filteredFriend.append(searchedSection)
                        }
                    }
                }
            }
        }
        // Обновляем данные
        self.tableView.reloadData()
    }
    
    // отмена поиска
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // показать кнопку кансл
        
        let cBtn = searchBar.value(forKey: "cancelButton") as! UIButton
        cBtn.backgroundColor = .lightGray
        cBtn.setTitleColor(.white, for: .normal)
        
        UIView.animate(withDuration: 0.3,
                       animations: {
            // Двигаем кнопку кансл
            cBtn.frame = CGRect(x: cBtn.frame.origin.x - 50,
                                y: cBtn.frame.origin.y,
                                width: cBtn.frame.width,
                                height: cBtn.frame.height)
            
            // Анимируем запуск поиска. -1 чтобы пошла анимация, тогда лупа плавно откатывается
            self.searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
                                          y: self.searchBar.frame.origin.y,
                                          width: self.searchBar.frame.size.width - 1,
                                          height: self.searchBar.frame.size.height)
            self.searchBar.layoutSubviews()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Анимацию возвращения в исходное состояние после нажатия кансл
        UIView.animate(withDuration: 0.2,
                       animations: {
            searchBar.showsCancelButton = false // скрываем кнопку кансл
            searchBar.text = nil
            searchBar.resignFirstResponder() // скрываем клавиатуру
        }, completion: { _ in
            let closure = self.searchBarAnimateClosure()
            closure()
        })
    }
}
