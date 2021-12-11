// Блок 9
// Задание 2
enum Seasons {
    case spring, summer, autumn, winter
}

enum Months {
    case january, february, march, april, may, june, july, august, september, october, november, december
}

enum names: String {
    case name = "John"
    case surname = "Black"
}

enum MobileOS {
    case iOS, Android
}

enum DevLanguages {
    case swift, python
}

// Задание 3
enum CV: String {
    case name = "Anton"
    case surname = "Golovatyy"
    case age = "32"
    case profession = "Sale"
    case hobby = "iOS development"
}

var mySelf = CV.name

if mySelf == .name {
    print(CV.name.rawValue)
}
mySelf = CV.surname
if mySelf == .surname {
    print(CV.surname.rawValue)
}
// и т.д. Скучное задание и явно неприменимое к практике.

// Задание 4
enum Color {
    case rose, red, green, blue
}

func colorDevices (iPhone: Color, macBook: Color, iPad: Color, appleWatch: Color) {
    print("iPhone -", iPhone)
    print("MacBook -", macBook)
    print("iPad -", iPad)
    print("Apple Watch -", appleWatch)
}

colorDevices(iPhone: .rose, macBook: .red, iPad: .green, appleWatch: .blue)
