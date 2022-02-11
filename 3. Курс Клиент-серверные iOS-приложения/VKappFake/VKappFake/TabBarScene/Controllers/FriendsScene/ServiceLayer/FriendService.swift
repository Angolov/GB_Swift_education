//
//  FriendService.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

import Foundation

/// Ошибки сервисного слоя для сценария "Друзья"
 enum FriendsError: Error {
	case parseError
	case requestError(Error)
}

fileprivate enum TypeMethods: String {
	case friendsGet = "/method/friends.get"
}

fileprivate enum TypeRequest: String {
	case get = "GET"
	case post = "POST"
}

/// Сервисный слой для сценария "Друзья"
final class FriendService {

	private let session: URLSession = {
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		return session
	}()


	/// Загрузить список друзей
	/// - Parameter completion: Блок, обрабатывающий результат
	func loadFriendVK(completion: @escaping ((Result<FriendsVK, FriendsError>) -> ())) {
		guard let token = SessionStorage.instance.token else {
			return
		}
		let params: [String: String] = ["v" : "5.81",
										"access_token" : token,
										"fields": "photo_50"
		]

		let url = configureUrl(token: token,
							   method: .friendsGet,
							   httpMethod: .get,
							   params: params)

		print(url)

		let task = session.dataTask(with: url) { data, _ , error in
			if let error = error {
				return completion(.failure(.requestError(error)))
			}
			guard let data = data else { return }
			let friends = JSONDecoder()

			do {
				let result = try friends.decode(FriendsVK.self, from: data)
				return completion(.success(result))
			} catch {
				return completion(.failure(.parseError))
			}
		}
		task.resume()
	}
}

// MARK: - Private
private extension FriendService {

	func configureUrl(token: String,
					  method: TypeMethods,
					  httpMethod: TypeRequest,
					  params: [String: String]) -> URL {

		let scheme = "https"
		let host = "api.vk.com"

		var queryItems = [URLQueryItem]()

		queryItems.append(URLQueryItem(name: "v", value: "5.131"))

		for (param, value) in params {
			queryItems.append(URLQueryItem(name: param, value: value))
		}

		var urlComponents = URLComponents()
		urlComponents.scheme = scheme
		urlComponents.host = host
		urlComponents.path = method.rawValue
		urlComponents.queryItems = queryItems

		guard let url = urlComponents.url else {
			fatalError("URL is invalid")
		}
		return url
	}
}

