//
//  FriendSection.swift
//  VKappFake
//
//  Created by Олег Ганяхин on 11.01.2022.
//

struct FriendsSection: Comparable {
	var key: Character
	var data: [Friend]

	static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
		return lhs.key < rhs.key
	}

	static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
		return lhs.key == rhs.key
	}
}
