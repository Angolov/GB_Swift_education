//
//  Singleton.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 13.11.2021.
//

import UIKit

class Session {

	static let instance = Session()

	private init() {}

	var id: Int?
	var token: String?
}
