//
//  SecretValue.swift
//  Right on target
//
//  Created by Антон Головатый on 20.12.2021.
//

typealias NumericSecretValue = SecretValue<Int>
typealias ColorSecretValue = SecretValue<Color>

//MARK: - SecretValueProtocol declaration
protocol SecretValueProtocol {
    associatedtype SecretType
    
    var value: SecretType { get }
    
    mutating func setRandomValue()
}

//MARK: - SecretValue class declaration
struct SecretValue<T: Equatable>: SecretValueProtocol {
    
    //MARK: - Public properties
    var value: T
    var randomValueClosure: (T) -> T
    
    //MARK: - Initializer
    init(value: T, randomValueClosure: @escaping (T) -> T) {
        self.value = value
        self.randomValueClosure = randomValueClosure
    }
    
    //MARK: - Public method
    mutating func setRandomValue() {
        value = randomValueClosure(value)
    }
}
