//
//  Friends.swift
//  GeekBrainsLesons
//
//  Created by Vitalii Sukhoroslov on 30.10.2021.
//

import UIKit

// Создадам наш массив друзей содержащих в себе Имя Аватарку и масив фотографий

class FriendsArray {
    
    static var friends = [FriendModel(name: "Александр", image: "1", friendsPhoto: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]),
                          FriendModel(name: "Алена", image: "2", friendsPhoto: ["2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20",]),
                          FriendModel(name: "Аврам", image: "3", friendsPhoto: ["3"]),
                          FriendModel(name: "Борис", image: "4", friendsPhoto: ["4"]),
                          FriendModel(name: "Боря", image: "5", friendsPhoto: ["5"]),
                          FriendModel(name: "Виталий", image: "6", friendsPhoto: ["6"]),
                          FriendModel(name: "Вова", image: "7", friendsPhoto: ["7"]),
                          FriendModel(name: "Ваня", image: "8", friendsPhoto: ["8"]),
                          FriendModel(name: "Галина", image: "9", friendsPhoto: ["9"]),
                          FriendModel(name: "Генадий", image: "10", friendsPhoto: ["10"]),
                          FriendModel(name: "Дмитрий", image: "11", friendsPhoto: ["11"]),
                          FriendModel(name: "Димон", image: "12", friendsPhoto: ["12"]),
                          FriendModel(name: "Данил", image: "13", friendsPhoto: ["13"]),
                          FriendModel(name: "Достоевский", image: "14", friendsPhoto: ["14"]),
                          FriendModel(name: "Елена", image: "15", friendsPhoto: ["15"]),
                          FriendModel(name: "Евгений", image: "16", friendsPhoto: ["16"]),
                          FriendModel(name: "Жора", image: "17", friendsPhoto: ["17"]),
                          FriendModel(name: "Жрец", image: "18", friendsPhoto: ["18"]),
                          FriendModel(name: "Иван", image: "19", friendsPhoto: ["19"]),
                          FriendModel(name: "Ивангай", image: "20", friendsPhoto: ["20"]),
                          FriendModel(name: "Ивангель", image: "21", friendsPhoto: ["21"]),
                          FriendModel(name: "Катерина", image: "22", friendsPhoto: ["22"]),
                          FriendModel(name: "Крокодил", image: "23", friendsPhoto: ["23"]),
                          FriendModel(name: "Картошка", image: "24", friendsPhoto: ["24"]),
                          FriendModel(name: "Лена", image: "25", friendsPhoto: ["25"]),
                          FriendModel(name: "Леонтий", image: "26", friendsPhoto: ["26"]),
                          FriendModel(name: "Лермантов", image: "27", friendsPhoto: ["27"]),
                          FriendModel(name: "Максим", image: "28", friendsPhoto: ["28"]),
                          FriendModel(name: "Михаил", image: "29", friendsPhoto: ["29"]),
                          FriendModel(name: "Мишаня", image: "30", friendsPhoto: ["30"]),
                          FriendModel(name: "Николай", image: "31", friendsPhoto: ["31"])
    ]
    
    static func iNeedFriends() -> [FriendsSection] {
        let sortedArray = sortFriends(friends)
        let sectionsArray = formFriendsSection(sortedArray)
        return sectionsArray
    }
    
    // Разбираем друзей по ключамБ в зависимости от первой буквы
    static func sortFriends(_ array: [FriendModel]) -> [Character: [FriendModel]] {
        var newArray: [Character: [FriendModel]] = [:]
        for friend in array {
            // проверяемБ чтобы строка имени не оказалась пустой
            guard let firstChar = friend.name.first else {
                continue
            }
            
            // если такого ключа нет, то создадим секцию с этим ключом
            guard var array = newArray[firstChar] else {
                let newValue = [friend]
                newArray.updateValue(newValue, forKey: firstChar)
                continue
            }
            
            // если секция нашлась то добавим в массив ещёё одну модель
            array.append(friend)
            newArray.updateValue(array, forKey: firstChar)
        }
        return newArray
    }
    
    static func formFriendsSection(_ array: [Character: [FriendModel]]) -> [FriendsSection] {
        var sectionArray: [FriendsSection] = []
        for (key, array) in array {
            sectionArray.append(FriendsSection(key: key, data: array))
        }
        
        // сортируем секции по алфавиту
        sectionArray.sort {$0 < $1}
        
        return sectionArray
    }
}
