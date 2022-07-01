//
//  Int+extension.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 30.05.2022.
//

import Foundation

//MARK: - Int extenstion for string formatting

extension Int {
    
    func formatToString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.decimalSeparator = ","
        numberFormatter.groupingSeparator = " "
        let nsNumber = NSNumber(value: self)
        
        guard let result = numberFormatter.string(from: nsNumber) else { return "" }
        
        return result
    }
}
