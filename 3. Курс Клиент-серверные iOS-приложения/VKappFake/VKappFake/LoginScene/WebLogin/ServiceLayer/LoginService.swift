//
//  LoginService.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 15.12.2021.
//

import Foundation

protocol LoginServiceInput {

	func loadAuth() -> URLRequest
}

final class LoginService: LoginServiceInput {

	func loadAuth() -> URLRequest {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "oauth.vk.com"
		urlComponents.path = "/authorize"
		urlComponents.queryItems = [
			URLQueryItem(name: "client_id", value: "8002318"),
			URLQueryItem(name: "display", value: "mobile"),
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
			URLQueryItem(name: "scope", value: "friends, photos, wall, groups"),
			URLQueryItem(name: "response_type", value: "token"),
			URLQueryItem(name: "v", value: "5.131")
		]

		let request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))

		return request
	}
}
