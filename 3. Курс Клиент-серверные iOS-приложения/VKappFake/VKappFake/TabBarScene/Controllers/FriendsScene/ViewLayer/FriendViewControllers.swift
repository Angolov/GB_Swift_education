//
//  FriendViewControllers.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

import UIKit

final class FriendViewController: UIViewController {

	var friends: [FriendsSection] = []
	var filteredData: [FriendsSection] = []
	var lettersOfNames: [String] = []

	let service = FriendsServiceManager()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .white
		return tableView
	}()

	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		setupConstraints()
		fetchFriends()
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FriendViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return filteredData.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredData[section].data.count
	}


	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let section = friends[section]
		return String(section.key)
	}

	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return lettersOfNames
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell",
													 for: indexPath) as? FriendsTableViewCell
		else {
			return UITableViewCell()
		}

		let section = filteredData[indexPath.section]

		DispatchQueue.main.async {
			cell.configureCell(with: section.data[indexPath.row])
		}

		return cell
	}
}

// MARK: - Private methods
private extension FriendViewController {

	/// Конфигурируем TableView
	func setupTableView() {
		tableView.frame = self.view.bounds
		tableView.rowHeight = 70
		tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "FriendsTableViewCell")
		tableView.showsVerticalScrollIndicator = false
		tableView.sectionHeaderTopPadding = 0
		tableView.sectionIndexColor = .black
		tableView.dataSource = self
		tableView.delegate = self
		self.view.addSubview(tableView)
	}

	/// Задаём констрейнты таблице
	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
		])
	}

	func loadLetters() {
		for user in friends {
			lettersOfNames.append(String(user.key))
		}
	}

	func fetchFriends() {
		service.loadFriends { [weak self] friends in
			guard let self = self else { return }
			self.friends = friends
			self.filteredData = friends
			self.loadLetters()
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}
