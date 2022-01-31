//
//  Calendar+.swift
//  TSD_lesson5
//
//  Created by Антон Головатый on 25.01.2022.
//

import Foundation

//MARK: - Calendar extension handler
extension Calendar {
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
    
    func numberOfYearsBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfYears = dateComponents([.year], from: fromDate, to: toDate)
        
        return numberOfYears.year!
    }
}
