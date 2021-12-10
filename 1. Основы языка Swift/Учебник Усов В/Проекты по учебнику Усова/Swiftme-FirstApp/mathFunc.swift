//
//  sumFunc.swift
//  Swiftme-FirstApp
//
//  Created by Антон Головатый on 22.11.2021.
//

func doOperation (_ operation: (Double, Double) -> Double,
                  with num1: Double,
                  and num2: Double) -> Double {
    operation(Double(num1), Double(num2))
}



