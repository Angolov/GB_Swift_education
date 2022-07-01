//
//  QuestionSettings.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import Foundation

//MARK: QuestionSettings enum declaration

enum QuestionSettings: Int, CaseIterable {
    case sequential
    case random
    
    var questionStrategy: QuestionStrategy {
        switch self {
        case .sequential:
            return SequentialQuestionStrategy()
        case .random:
            return RandomQuestionStrategy()
        }
    }
}
