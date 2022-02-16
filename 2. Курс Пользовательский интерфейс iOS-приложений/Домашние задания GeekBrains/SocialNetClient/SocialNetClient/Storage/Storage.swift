//
//  Storage.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 15.01.2022.
//

import Foundation
import UIKit

//MARK: - Storage (Singleton) class declaration
final class Storage: NSObject {
    
    //MARK: - Type properties
    static let shared = Storage()
    
    //MARK: - Private properties
    private var storage = UserDefaults.standard
    private var groupsStorageKey: String = "groups"
    private var likesStorageKey: String = "likes"
    
    private enum GroupKey: String {
        case name
        case avatarName
        case description
    }
    
    private enum UserKey: String {
        case name
        case photos
        case likes
        case isLiked
    }
    
    //MARK: - Public properties
    var friends = [UserProtocol]() {
        didSet {
            friends.sort { $0.name < $1.name }
            saveLikesToUserDefaults(friends)
        }
    }
    var userGroups: [GroupProtocol] = [] {
        didSet {
            saveGroupsToUserDefaults(userGroups)
        }
    }
    var allGroups = [GroupProtocol]()
    
    var news = [NewsProtocol]() {
        didSet {
            news.sort { $0.date > $1.date }
        }
    }
    
    //MARK: - Private initializer
    private override init() {
        super.init()
        loadGroups()
        //friends = loadFriendsList()
        friends = loadLikesFromUserDefaults()
        userGroups = loadGroupsFromUserDefaults()
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
    
    private func loadLikesFromUserDefaults() -> [UserProtocol] {

        var resultFriends: [UserProtocol] = loadFriendsList()
        let friendsFromStorage = storage.array(forKey: likesStorageKey) as? [[String:[String]]] ?? []
        
        for friend in friendsFromStorage {
            guard let name = friend[UserKey.name.rawValue],
                  let photoImageNames = friend[UserKey.photos.rawValue],
                  let likesInString = friend[UserKey.likes.rawValue],
                  let isLikedInString = friend[UserKey.isLiked.rawValue] else { continue }
            
            var likesInInt = [Int]()
            likesInString.forEach { string in
                if let like = Int(string) {
                    likesInInt.append(like)
                }
            }
            var isLikedInBool = [Bool]()
            isLikedInString.forEach { string in
                if let isLiked = Bool(string) {
                    isLikedInBool.append(isLiked)
                }
            }
            
            if likesInString.count == likesInInt.count,
               isLikedInString.count == isLikedInBool.count,
               photoImageNames.count == likesInInt.count,
               photoImageNames.count == isLikedInBool.count,
               let index = resultFriends.firstIndex(where: {$0.name == name[0]}) {
                resultFriends[index].likes = likesInInt
                resultFriends[index].isLiked = isLikedInBool
            }
        }

        return resultFriends
    }

    private func saveLikesToUserDefaults(_ friends: [UserProtocol]) {

        var arrayForStorage: [[String:[String]]] = []

        friends.forEach { friend in

            var newElementForStorage: Dictionary<String, [String]> = [:]
            newElementForStorage[UserKey.name.rawValue] = [friend.name]
            newElementForStorage[UserKey.photos.rawValue] = friend.photosImageNames
            
            var likesToString = [String]()
            friend.likes.forEach { like in
                likesToString.append(String(like))
            }
            newElementForStorage[UserKey.likes.rawValue] = likesToString
            
            var isLikedToString = [String]()
            friend.isLiked.forEach { isLiked in
                isLikedToString.append(String(isLiked))
            }
            newElementForStorage[UserKey.isLiked.rawValue] = isLikedToString
            
            arrayForStorage.append(newElementForStorage)
        }

        storage.set(arrayForStorage, forKey: likesStorageKey)

    }
    
    private func loadGroups() {
        
        guard let image1 = UIImage(named: "friend1"),
              let image2 = UIImage(named: "friend2"),
              let image3 = UIImage(named: "friend3"),
              let image4 = UIImage(named: "friend4") else { return }
        
        allGroups.append(Group(name: "Рога и копыта",
                               avatar: image1,
                               avatarImageName: "friend1",
                               description: "Группа о животных"))
        allGroups.append(Group(name: "Алкоголики",
                               avatar: image2,
                               avatarImageName: "friend2",
                               description: "Анонимная группа поддержки"))
        allGroups.append(Group(name: "Наш район",
                               avatar: image3,
                               avatarImageName: "friend3",
                               description: "Делаем район лучше, чище и безопаснее"))
        allGroups.append(Group(name: "Свежие новости",
                               avatar: image4,
                               avatarImageName: "friend4",
                               description: "Самые свежие новости только тут!"))
    }
    
    private func loadGroupsFromUserDefaults() -> [GroupProtocol] {
        
        var resultGroups: [GroupProtocol] = []
        let groupsFromStorage = storage.array(forKey: groupsStorageKey) as? [[String:String]] ?? []

        for group in groupsFromStorage {

            guard let name = group[GroupKey.name.rawValue],
                  let imageName = group[GroupKey.avatarName.rawValue],
                  let image = UIImage(named: imageName),
                  let description = group[GroupKey.description.rawValue] else { continue }
            
            resultGroups.append(Group(name: name,
                                    avatar: image,
                                    avatarImageName: imageName,
                                    description: description))
        }
        
        return resultGroups
    }
    
    private func saveGroupsToUserDefaults(_ groups: [GroupProtocol]) {
        
        var arrayForStorage: [[String:String]] = []
        
        groups.forEach { group in
            
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[GroupKey.name.rawValue] = group.name
            newElementForStorage[GroupKey.avatarName.rawValue] = group.avatarImageName
            newElementForStorage[GroupKey.description.rawValue] = group.description
            arrayForStorage.append(newElementForStorage)
        }
        
        storage.set(arrayForStorage, forKey: groupsStorageKey)
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
