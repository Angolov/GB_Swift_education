//
//  QuestionsCaretacker.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import Foundation

//MARK: - QuestionsCaretacker class declaration

final class QuestionsCaretacker {
    
    //MARK: - Properties
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "questions"
    
    //MARK: - Methods
    
    func save(questions: [Question]) {
        do {
            let data = try encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
