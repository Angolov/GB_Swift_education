// Урок 27
// Задание 1 (единственное)

enum DayOfWeek: Int {
    
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    init?(day: String) {
        
        switch day.lowercased() {
        
        case "понедельник":
            self = .monday
        case "вторник":
            self = .tuesday
        case "среда":
            self = .wednesday
        case "четверг":
            self = .thursday
        case "пятница":
            self = .friday
        case "суббота":
            self = .saturday
        case "воскресенье":
            self = .sunday
        default:
            return nil
        }
    }
}

let goodDay = DayOfWeek(day: "ПоНеДЕЛьниК")
let wrongDay = DayOfWeek(day: "skdfjhsdjkf")
