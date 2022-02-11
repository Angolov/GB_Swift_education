//
//  News.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

class NewsArray {
    static func iNeedNews() -> [NewsMainViewCellModel] {
        return [NewsMainViewCellModel(nameFriend: FriendModel(name: "Борис",
                                                              image: "4",
                                                              friendsPhoto: []),
                                      postDate: "23.10.2021",
                                      postText: "Всем привет ! Сидим учим разбираем что куда как и почему )))",
                                      newsImageNames: ["1", "2", "3", "4", "5"]),
                NewsMainViewCellModel(nameFriend: FriendModel(name: "Боря",
                                                                      image: "5",
                                                                      friendsPhoto: []),
                                              postDate: "24.10.2021",
                                              postText: "Всем привет ! Сидим учим разбираем что куда как и почему )))",
                                              newsImageNames: ["1", "2", "3", "4", "5", "6", "7"]),

                NewsMainViewCellModel(nameFriend: FriendModel(name: "Алена",
                                                                      image: "1",
                                                                      friendsPhoto: []),
                                              postDate: "25.10.2021",
                                              postText: "Всем привет ! Сидим учим разбираем что куда как и почему )))",
                                              newsImageNames: ["1", "2"]),

                NewsMainViewCellModel(nameFriend: FriendModel(name: "Виталий",
                                                                      image: "6",
                                                                      friendsPhoto: []),
                                              postDate: "26.10.2021",
                                              postText: "Всем привет ! Сидим учим разбираем что куда как и почему )))",
                                              newsImageNames: ["1"]),

                NewsMainViewCellModel(nameFriend: FriendModel(name: "Борис", image: "4", friendsPhoto: []),
                                              postDate: "27.10.2021", postText: "Всем привет ! Сидим учим разбираем что куда как и почему )))",
                                              newsImageNames: ["1", "2", "3"])]
    }
}
