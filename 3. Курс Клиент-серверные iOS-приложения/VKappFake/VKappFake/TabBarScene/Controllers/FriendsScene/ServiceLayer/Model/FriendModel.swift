//
//  FriendModel.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

// Создадим структуру определяющая в целом обьект полученый с сервера
struct FriendsVK: Decodable {
	let response: ResponseFriends
}
// Создадим структуру определяющую что хранит в себе обьект
struct ResponseFriends: Decodable {
	let count: Int
	let items: [Friend]
}

// созщдадим структуру которая определит данные которые нужно выдернуть из обьекта итем
struct Friend: Decodable {
	let id: Int
	let firstName, lastName: String
	let photo50: String

	// создадим енум которая вытащит данные из обьекта которые нам нужны для дальнейшей работы
	enum CodingKeys: String, CodingKey {
		case id
		case firstName = "first_name"
		case lastName = "last_name"
		case photo50 = "photo_50"
	}
}
