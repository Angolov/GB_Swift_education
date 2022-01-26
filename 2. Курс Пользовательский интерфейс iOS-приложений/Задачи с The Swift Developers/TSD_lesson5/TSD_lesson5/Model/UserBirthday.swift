//
//  UserBirthday.swift
//  TSD_lesson5
//
//  Created by Антон Головатый on 25.01.2022.
//

import Foundation
import UIKit

//MARK: - UserBirthdayProtocol protocol declaration
protocol UserBirthdayProtocol {
    
    var name: String { get set }
    var birthDate: Date { get set }
    var photo: UIImage { get set }
    var age: Int { get set }
    var daysBeforeBirthday: Int { get set }
}

//MARK: - UserBirthday struct declaration
struct UserBirthday: UserBirthdayProtocol {
    
    //MARK: - Public properties
    var name: String
    var birthDate = Date()
    var photo: UIImage
    var age = 0
    var daysBeforeBirthday = 0
    
    //MARK: - Initializers
    init(name: String, birthDate: String, photo: UIImage) {
        self.name = name
        self.photo = photo
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        guard let date = dateFormatter.date(from: birthDate) else { return }
        self.birthDate = date
        self.age = getAge()
        self.daysBeforeBirthday = getDaysBeforeBirthday()
    }
    
    //MARK: - Private methods
    private func getAge() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.numberOfYearsBetween(birthDate, and: Date(timeIntervalSinceNow: 0))
    }
    
    private func getDaysBeforeBirthday() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        guard let nextBirthday = calendar.date(byAdding: .year,
                                               value: age + 1,
                                               to: birthDate) else { return 0 }
        return calendar.numberOfDaysBetween(Date(timeIntervalSinceNow: 0), and: nextBirthday)
    }
}
