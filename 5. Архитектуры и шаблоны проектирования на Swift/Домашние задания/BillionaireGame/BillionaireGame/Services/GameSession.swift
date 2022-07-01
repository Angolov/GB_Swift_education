//
//  GameSession.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 27.05.2022.
//

import Foundation

//MARK: - GameSessionDelegate protocol declaration

protocol GameSessionDelegate {
    func nextQuestion()
    func checkAnswer(_ answer: String) -> Bool
}

//MARK: - GameSession class declaration

final class GameSession {
    
    //MARK: - Properties
    
    private let maxQuestionsCount = 15
    private let moneyArray: [Int] = [500, 750, 1500, 3000, 5000, 7500, 10000, 15000,
                                     30000, 60000, 80000, 100000, 250000, 500000, 1000000]
    private let moneyIndexStart: Int
    
    let questionStrategy: QuestionStrategy
    let hintUsageFacade: HintUsageFacade
    
    var questionsData: [Question]
    var questionsCount: Int
    var index = Observable<Int>(0)
    
    var friendHelpAvailable = true
    var viewersHelpAvailable = true
    var fiftyHelpAvailable = true
    
    var currentMoney: Int {
        if index.value < 0 {
            return 0
        } else if index.value >= moneyArray.count - 1 {
            return moneyArray[moneyArray.count - 1]
        } else {
            return moneyArray[index.value + moneyIndexStart]
        }
    }
    
    var delegate: GameSessionDelegate?
    
    //MARK: - Initializer
    
    init(questionStrategy: QuestionStrategy) {
        self.questionStrategy = questionStrategy
        
        questionsData = [
            Question(question: "Какой вопрос, по определению, не требует ответа?",
                     answersArray: ["Каверзный", "Риторический", "Философский", "Экзаменационный"],
                     correctAnswer: "Риторический"),
            Question(question: "Как называют человека, который очень много ест?",
                     answersArray: ["Полиглот", "Дистрофик", "Обжора", "Кусочник"],
                     correctAnswer: "Обжора"),
            Question(question: "Как иногда называют малознакомого человека?",
                     answersArray: ["Тёмная лошадка", "Белая ворона", "Чёрная кошка", "Сизый голубь"],
                     correctAnswer: "Тёмная лошадка"),
            Question(question: "Этот строительный материал НЕ входит в состав Пирамиды Хеопса.",
                     answersArray: ["Базальт", "Гранит", "Известня", "Асбест"],
                     correctAnswer: "Асбест"),
            Question(question: "В честь чего был назван компьютер компании - Макинтош?",
                     answersArray: ["Сорт яблок", "Вид плаща", "Зонт", "Населённый пункт"],
                     correctAnswer: "Сорт яблок"),
            Question(question: "Какая масть является самой старшей при игре в преферанс?",
                     answersArray: ["Пики", "Черви", "Трефы", "Бубны"],
                     correctAnswer: "Черви"),
            Question(question: "В каком году появился Дзержинский район?",
                     answersArray: ["1935", "1932", "1934", "1933"],
                     correctAnswer: "1933"),
            Question(question: "Что коллекционирует филуменист?",
                     answersArray: ["Фотографии", "Пробки", "Спичечные коробки", "Предметы живописи"],
                     correctAnswer: "Спичечные коробки"),
            Question(question: "Какая страна, использующая правостороннее движение на автомобильных дорогах, имеет левостороннее железнодорожное сообщение?",
                     answersArray: ["США", "Китай", "Германия", "Франция"],
                     correctAnswer: "Франция"),
            Question(question: "Как в переводе с финского означает название Kaarlahti, которое носил посёлок до 1940 года?",
                     answersArray: ["Гранитный город", "Изогнутый залив", "Красивое место", "Скалистая местность"],
                     correctAnswer: "Изогнутый залив")
        ]
        
        let questions = Game.shared.retrieveUsersQuestions()
        if questions.count > 0 {
            questionsData += questions
        }
        
        questionsCount = questionsData.count > maxQuestionsCount ? maxQuestionsCount : questionsData.count
        moneyIndexStart = moneyArray.count - questionsCount
        
        hintUsageFacade = HintUsageFacade(question: questionsData[0])
    }
}
