//
//  TabBarController.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

import UIKit

final class CustomTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tabBar.tintColor = .black
		self.tabBar.barTintColor = .white
		self.tabBar.unselectedItemTintColor = .gray
		self.tabBar.backgroundColor = .white
		setupVCs()
	}

	/// Cоздаём и конфигурируем Navigation Контроллеры, которые будут отображены в табах
	private func setupVCs() {

//		let myGroups = createNavController(for: ,title: "Мои группы", image: UIImage(systemName: "person.3")!)

		let friends = createNavController(for: FriendViewController(),
											 title: "Друзья",
											 image: UIImage(systemName: "person")!)

//		let news = createNavController(for: NewsController(
//			model: newsVM),
//										  title: "Новости", image: UIImage(systemName: "newspaper")!)

		viewControllers = [friends]
	}

	private func createNavController(for rootViewController: UIViewController,
									 title: String,
									 image: UIImage) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		rootViewController.navigationItem.title = title
		navController.navigationBar.tintColor = .black
		return navController
	}
}
