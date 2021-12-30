//
//  Model.swift
//  TSD_lesson3_5-6
//
//  Created by Антон Головатый on 30.12.2021.
//

//MARK: - Hello protocol declaration
protocol HelloProtocol {
    
    func helloTransformFrom(_ text: String) -> String?
    
}
//MARK: - Hello class declaration
final class Hello: HelloProtocol {
    
    func helloTransformFrom(_ text: String) -> String? {
        
        if text == "leohl" {
            return "hello"
            
        } else {
            return nil
        }
    }
}
