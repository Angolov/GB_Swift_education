//
//  ResultsCaretacker.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import Foundation

//MARK: - ResultsCaretacker class declaration

final class ResultsCaretacker {
    
    //MARK: - Properties
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "results"
    
    //MARK: - Methods
    
    func save(results: [Results]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> [Results] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([Results].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
