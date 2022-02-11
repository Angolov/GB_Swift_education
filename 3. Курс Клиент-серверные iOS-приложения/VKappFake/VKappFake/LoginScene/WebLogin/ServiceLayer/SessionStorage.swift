//
//  SessionStorage.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

class SessionStorage {
	/// Токен авторизации
	var token: String?

	/// ID пользователя, под которым авторизовались
	var userID: Int?

	///  Инстанс синглтона Session
	static let instance = SessionStorage()

	private init() {}

	/// Сохраняет данные авторизации пользователя
	func loginUser(with token: String, userId: Int) {
		self.token = token
		self.userID = userId
		print("Token: \(token)")
	}
}
