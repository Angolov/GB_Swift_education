//
//  FriendsServiceManager.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

import UIKit

class FriendsServiceManager {

	private var service = FriendService()
	private let imageService = ImageLoader()
	
	private func sortFriends(_ array: [Friend]) -> [Character: [Friend]] {

		var newArray: [Character: [Friend]] = [:]

		for user in array {
			//проверяем, чтобы строка имени не оказалась пустой
			guard let firstChar = user.firstName.first else {
				continue
			}

			// Если секции с таким ключом нет, то создадим её
			guard var array = newArray[firstChar] else {
				let newValue = [user]
				newArray.updateValue(newValue, forKey: firstChar)
				continue
			}

			// Если секция нашлась, то добавим в массив ещё модель
			array.append(user)
			newArray.updateValue(array, forKey: firstChar)
		}
		return newArray
	}

	private func formFriendsSections(_ array: [Character: [Friend]]) -> [FriendsSection] {
		var sectionsArray: [FriendsSection] = []
		for (key, array) in array {
			sectionsArray.append(FriendsSection(key: key, data: array))
		}
		sectionsArray.sort { $0 < $1 }

		return sectionsArray
	}

	private func formFriendsArray(from array: [Friend]?) -> [FriendsSection] {
		guard let array = array else {
			return []
		}
		let sorted = sortFriends(array)
		return formFriendsSections(sorted)
	}

	/// Загружает список друзей
	func loadFriends(completion: @escaping ([FriendsSection]) -> Void) {
		service.loadFriendVK { [weak self] result in
			switch result {
			case .success(let friend):
				guard let section = self?.formFriendsArray(from: friend.response.items) else { return }
				completion(section)
			case .failure(_):
				return
			}
		}
	}

	func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
		guard let url = URL(string: url) else { return }
		imageService.loadImage(url: url) { result in
			switch result {
			case .success(let data):
				guard let image = UIImage(data: data) else { return }
				completion(image)
			case .failure(let error):
				debugPrint("Error: \(error.localizedDescription)")
			}
		}
	}
}

