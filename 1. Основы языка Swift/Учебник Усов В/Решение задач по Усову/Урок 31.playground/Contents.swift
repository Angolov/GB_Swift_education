// Урок 31
// Задание 1
extension Int {
    
    var asDouble: Double {
        
        return Double(self)
        
    }
    
    var asFloat: Float {
        
        return Float(self)
        
    }
    
    var asString: String {
        
        return String(self)
        
    }
    
}

let someInt = 12
someInt.asDouble
someInt.asFloat
someInt.asString


// Задание 2
extension String {
    
    func crypt() -> String{
        
        let words = self.split(separator:" ")
        var resultStr = ""
        
        for word in words {
            
            var newWord = String(word)
            
            if newWord.count >= 3 {
                
                let secondCharIndex = newWord.index(after: newWord.startIndex)
                let tmp_secondChar = newWord[secondCharIndex]
                let lastCharIndex = newWord.index(before: newWord.endIndex)
                
                newWord.replaceSubrange(
                    secondCharIndex..<newWord.index(after: secondCharIndex),
                    with: String(newWord[lastCharIndex]))
                
                newWord.replaceSubrange(
                    lastCharIndex..<newWord.index(after: lastCharIndex),
                    with: String(tmp_secondChar))
            }
            
            let codePoint = newWord.unicodeScalars[newWord.startIndex].value
            
            newWord.replaceSubrange(
                newWord.startIndex..<newWord.index(after: newWord.startIndex),
                with: String(codePoint))
            
            resultStr += "\(newWord) "
        }
        
        resultStr.remove(at: resultStr.index(before: resultStr.endIndex))
        
        return resultStr
    }
    
}

let someString = "Я учу Swift"


someString.crypt()


// Задание 3
extension Double {
    
    var km: Double {
        
        return self * 100000
        
    }
    
    var m: Double {
        
        return self * 100
        
    }
    
    var sm: Double {
        
        return self
        
    }
    
    var mm: Double {
        
        return self / 10
        
    }
}

Double(102).m //10200
1.2.km //120000
900.sm //900

// Задание 4
extension Double {
    
    var toKM: Double {
        
        return self / 100000
        
    }
    
    var toM: Double {
        
        return self / 100
        
    }
    
    var toSM: Double {
        
        return self
        
    }
    
    var toMM: Double {
        
        return self * 10
        
    }
    
}

100.1.toM // 1.001
Double(5).km.toM // 5000
Double(150).m.toKM // 0.15


// Задание 5
extension Int {
    
    mutating func iterator(count: Int, closure: (Int) -> Int) -> Int {
        
        for _ in 1...count {
            
            self = closure(self)
            
        }
        
        return self
    }
}

//3 раза умножить число 2 на 5
var a = 2
a.iterator(count: 3) {$0 * 5}
a // 250

// Задание 6
extension Int {
    
    subscript(index: Int) -> Int? {
        
        guard String(self).count >= index, index > 0 else { return nil }
        
        var number = self
        var result = 0
        
        for _ in index...String(self).count {
            
            result = number % 10
            number /= 10
            
        }
        
        return result
    }
    
}


54[1] //5
98[-2] // nil
123[3] //3
34[4] //nil

