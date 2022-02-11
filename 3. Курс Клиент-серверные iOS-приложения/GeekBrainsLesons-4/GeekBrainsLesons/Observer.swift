//
//  Observer.swift
//  GeekBrainsLesons
//
//  Created by Олег Ганяхин on 10.02.2022.
//

import Foundation

/// Сущность, которая хранит указатель на покупателей
struct WeakBuyer {
	weak var buyer: Buyer?
}

/// Магазин
class Shop {

	/// Массив подписчиков
	var listeners: [WeakBuyer] = []

	/// Зарегистрировать подписчиков
	/// - Parameter buyer: Подписчик
	func subscribe(buyer: Buyer) {
		let weakBuyer = WeakBuyer(buyer: buyer)
		listeners.append(weakBuyer)
	}

	/// Уведомить
	func notify() {
		listeners.forEach { $0.buyer?.takeInfo() }
	}
}

/// Покупатель
class Buyer {

	/// Действие, которое реагирует на уведомление
	func takeInfo() {
		print(#function)
	}
}
