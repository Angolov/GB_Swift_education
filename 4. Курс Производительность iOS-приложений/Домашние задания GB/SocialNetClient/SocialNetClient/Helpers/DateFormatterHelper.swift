//
//  DateFormatterHelper.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 29.03.2022.
//

import Foundation

//MARK: - DateFormatterHelper singleton declaration
final class DateFormatterHelper {
    
    //MARK: - Type roperties
    static let shared = DateFormatterHelper()
    
    //MARK: - Private initializer
    private init() {}
    
    //MARK: - Public property
    public let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter
    }()
}
