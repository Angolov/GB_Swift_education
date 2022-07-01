import UIKit

//MARK: - Data section

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")


// MARK: - Person struct declaration

struct Person: Decodable {
    var name: String
    var age: Int
    var isDeveloper: Bool
}

// MARK: - JSONParser protocol declaration

protocol JSONParser {
    var next: JSONParser? { get set }
    
    func getData(from: Data) -> [Person]?
}

// MARK: - DataJsonParser class declaration

class DataJsonParser: JSONParser {
    
    struct PersonsData: Decodable {
        var data: [Person]
    }
    
    var next: JSONParser?
    
    func getData(from data: Data) -> [Person]? {
        if let persons = try? JSONDecoder().decode(PersonsData.self, from: data).data {
            return persons
        } else {
            return next?.getData(from: data)
        }
    }
}

// MARK: - ResultJsonParser class declaration

class ResultJsonParser: JSONParser {
    
    struct PersonsResult: Decodable {
        var result: [Person]
    }
    
    var next: JSONParser?
    
    func getData(from data: Data) -> [Person]? {
        if let persons = try? JSONDecoder().decode(PersonsResult.self, from: data).result {
            return persons
        } else {
            return next?.getData(from: data)
        }
    }
}

// MARK: - GeneralJsonParser class declaration

class GeneralJsonParser: JSONParser {
    
    var next: JSONParser?
    
    func getData(from data: Data) -> [Person]? {
        if let persons = try? JSONDecoder().decode([Person].self, from: data) {
            return persons
        } else {
            return next?.getData(from: data)
        }
    }
}

let dataParser = DataJsonParser()
let resultParser = ResultJsonParser()
let generalParser = GeneralJsonParser()
dataParser.next = resultParser
resultParser.next = generalParser

var array = dataParser.getData(from: data1)
array = dataParser.getData(from: data2)
array = dataParser.getData(from: data3)
