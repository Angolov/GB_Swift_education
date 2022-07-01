//
//  Storage.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import Foundation

//MARK: - Storage (Singleton) class declaration

final class Storage: NSObject {
    
    //MARK: - Type properties
    
    static let shared = Storage()
    
    //MARK: - Private properties
    
    private var storage = UserDefaults.standard
    private var groupsStorageKey: String = "groups"
    private var likesStorageKey: String = "likes"
    
    
    private enum UserKey: String {
        case name
        case photos
        case likes
        case isLiked
    }
    
    //MARK: - Public properties
    
    var friends = [UserProtocol]()
    var news = [NewsProtocol]() {
        didSet {
            news.sort { $0.date > $1.date }
        }
    }
    
    //MARK: - Private initializer
    
    private override init() {
        super.init()
        friends = loadFriendsList()
        news = loadNews()
    }
    
    //MARK: - Private methods
    
    private func loadFriendsList() -> [UserProtocol] {
        
        var resultFriends = [UserProtocol]()
        
        resultFriends.append(User(name: "Михаил Юсупов",
                            avatarImageName: "friend1",
                            photosImageNames: Array(repeating: "friend1", count: 5),
                            likes: [10, 12, 2, 5, 3],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Андрей Неверов",
                            avatarImageName: "friend2",
                            photosImageNames: Array(repeating: "friend2", count: 5),
                            likes: [7, 6, 24, 15, 32],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Илья Сафонов",
                            avatarImageName: "friend3",
                            photosImageNames: Array(repeating: "friend3", count: 5),
                            likes: [0, 21, 72, 9, 44],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Роберт Мартин",
                            avatarImageName: "friend4",
                            photosImageNames: Array(repeating: "friend4", count: 5),
                            likes: [87, 9, 13, 47, 5],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Кирилл Николаев",
                            avatarImageName: "friend1",
                            photosImageNames: Array(repeating: "friend1", count: 5),
                            likes: [10, 12, 2, 5, 3],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Артем Никитин",
                            avatarImageName: "friend2",
                            photosImageNames: Array(repeating: "friend2", count: 5),
                            likes: [7, 6, 24, 15, 32],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Николай Антонов",
                            avatarImageName: "friend3",
                            photosImageNames: Array(repeating: "friend3", count: 5),
                            likes: [0, 21, 72, 9, 44],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Фредерик Бауменшталь",
                            avatarImageName: "friend4",
                            photosImageNames: Array(repeating: "friend4", count: 5),
                            likes: [87, 9, 13, 47, 5],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Джон Смит",
                            avatarImageName: "friend1",
                            photosImageNames: Array(repeating: "friend1", count: 5),
                            likes: [10, 12, 2, 5, 3],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Джеймс Абрамс",
                            avatarImageName: "friend2",
                            photosImageNames: Array(repeating: "friend2", count: 5),
                            likes: [7, 6, 24, 15, 32],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Роберт Блэк",
                            avatarImageName: "friend3",
                            photosImageNames: Array(repeating: "friend3", count: 5),
                            likes: [0, 21, 72, 9, 44],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Альберт Штайнмайер",
                            avatarImageName: "friend4",
                            photosImageNames: Array(repeating: "friend4", count: 5),
                            likes: [87, 9, 13, 47, 5],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Мария Синицина",
                            avatarImageName: "friend1",
                            photosImageNames: Array(repeating: "friend1", count: 5),
                            likes: [10, 12, 2, 5, 3],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Жанна Белова",
                            avatarImageName: "friend2",
                            photosImageNames: Array(repeating: "friend2", count: 5),
                            likes: [7, 6, 24, 15, 32],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Лидия Иванова",
                            avatarImageName: "friend3",
                            photosImageNames: Array(repeating: "friend3", count: 5),
                            likes: [0, 21, 72, 9, 44],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.append(User(name: "Зоя Кожина",
                            avatarImageName: "friend4",
                            photosImageNames: Array(repeating: "friend4", count: 5),
                            likes: [87, 9, 13, 47, 5],
                            isLiked: Array(repeating: false, count: 5)))
        resultFriends.sort { $0.name < $1.name }
        
        return resultFriends
    }
    
    private func loadNews() -> [NewsProtocol] {
        
        var resultNews = [News]()
        
        let secondsInDay = 24 * 60 * 60
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let newsText = """
В этом руководстве вы найдете базовую информацию о принципах работы API ВКонтакте и о подготовке к его использованию. Если вы уже работали с нашим API или с аналогичными сервисами других платформ, и знаете, какое приложение хотите создать, мы рекомендуем вам перейти в соответствующий раздел документации.
API (application programming interface) — это посредник между разработчиком приложений и какой-либо средой, с которой это приложение должно взаимодействовать. API упрощает создание кода, поскольку предоставляет набор готовых классов, функций или структур для работы с имеющимися данными.
"""
        
        for _ in 1...10 {
            
            let randomPoster = friends[Int.random(in: 0..<friends.count)]
            let postDate = Date(timeIntervalSinceNow: -TimeInterval(Int.random(in: 1...60) * secondsInDay))
            let postDateInString = dateFormatter.string(from: postDate)
            let photosCount = Int.random(in: 1...6)
            var photosNames = [String]()
            
            for _ in 0...photosCount {
                let photoName = "friend\(Int.random(in: 1...4))"
                photosNames.append(photoName)
            }
            
            resultNews.append(News(authorName: randomPoster.name,
                                   authorAvatarImageName: randomPoster.avatarImageName,
                                   date: postDate,
                                   dateInString: postDateInString,
                                   photosNames: photosNames,
                                   text: newsText,
                                   likes: Int.random(in: 0...187),
                                   isLiked: false,
                                   views: Int.random(in: 42...10000)))
        }
        
        resultNews.sort { $0.date > $1.date }
        
        return resultNews
    }
}
