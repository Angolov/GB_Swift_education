//
//  +Double.swift
//  BillionaireGame
//
//  Created by Антон Головатый on 02.06.2022.
//

import Foundation

//MARK: - Double extenstion for string formatting

extension Double {
    
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
