//
//  FriendCell.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

import UIKit

final class FriendsTableViewCell: UITableViewCell {

	let serviceManager = FriendsServiceManager()

	func configureCell(with model: Friend) {
		serviceManager.loadImage(url: model.photo50) { [weak self] image in
			guard let self = self else { return }
				self.imageView?.image = image
		}
		self.textLabel?.text = model.firstName
		self.detailTextLabel?.text = model.lastName
	}
}
