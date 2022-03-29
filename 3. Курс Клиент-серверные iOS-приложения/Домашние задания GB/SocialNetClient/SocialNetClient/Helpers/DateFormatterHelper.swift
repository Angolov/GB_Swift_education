//
//  DateFormatterHelper.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 29.03.2022.
//

import Foundation

final class DateFormatterHelper {
    
    static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter
    }()
}
