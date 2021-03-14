
import Foundation

// Частина 1
// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."
let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія - ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи
var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут
let studentsArray = studentsStr.components(separatedBy: "; ")

for student in studentsArray {
    let name_group = student.components(separatedBy: " - ")
    if var group = studentsGroups[name_group[1]] {
        group.append(name_group[0])
        studentsGroups[name_group[1]] = group
    } else {
        studentsGroups[name_group[1]] = [name_group[0]]
    }
}

studentsGroups.forEach { group, students in
    studentsGroups[group] = students.sorted()
}

// Ваш код закінчується тут
print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками
let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)
func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут
for item in studentsGroups {
    var studentsMarks: [String: [Int]] = [:]
    for student in item.value {
        var marks: [Int] = []
        points.forEach() { mark in
            marks.append(randomValue(maxValue: mark))
        }
        studentsMarks[student] = marks
    }
    studentPoints[item.key] = studentsMarks
}


// Ваш код закінчується тут
print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента
var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут
studentPoints.forEach { group in
    var studentMarks: [String: Int] = [:]
    group.value.forEach { (student) in
        let markSum = student.value.reduce(0, +)
        studentMarks[student.key] = markSum
    }
    sumPoints[group.key] = studentMarks
}


// Ваш код закінчується тут
print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи
var groupAvg: [String: Float] = [:]

// Ваш код починається тут
sumPoints.forEach { group, students in
    let pointSum = students.map {$0.value}.reduce(0, +)
    groupAvg[group] = Float(pointSum) / Float(students.count)
}


// Ваш код закінчується тут
print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів
var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут
sumPoints.forEach { group, students in
    var moreThan60: [String] = []
    students.forEach { name, mark in
        if mark > 60 {
            moreThan60.append(name)
        }
    }
    passedPerGroup[group] = moreThan60
}


// Ваш код закінчується тут
print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

// Частина 2
enum Direction {
    case Latitude, Longtitude
}

class CoordinateAB {
    var degrees: Int
    var minutes: UInt
    var seconds: UInt
    var direction: Direction
    
    
    init(direction: Direction = .Latitude, degrees: Int = 0, minutes: UInt = 0, seconds: UInt = 0) {
        self.direction = direction
        self.degrees = degrees
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func setDefault() -> Void {
        self.degrees = 0
        self.minutes = 0
        self.seconds = 0
    }
    
    func setCoords(direction: Direction, degrees: Int, minutes: UInt, seconds: UInt) -> Void {
        self.direction = direction
        
        switch (degrees, direction) {
        case (-90...90, .Latitude) :
            self.degrees = degrees
        case (-180...180, .Longtitude) :
            self.degrees = degrees
        default:
            fatalError("Degrees are not correct")
        }
        
        switch minutes {
        case 0..<60 :
            self.minutes = minutes
        default:
            fatalError("Minutes are not correct")
        }
        
        switch seconds {
        case 0..<60 :
            self.seconds = seconds
        default:
            fatalError("Seconds are not correct")
        }
    }
    
    func getPossition() -> String {
        var position: String
        switch (self.direction, self.degrees) {
        case (.Latitude, 0...):
            position = "N"
        case (.Latitude, ..<0):
            position = "S"
        case (.Longtitude, 0...):
            position = "W"
        case (.Longtitude, ..<0):
            position = "E"
        default:
            position = ""
            print("Something wrong")
        }

        return position
    }
    
    func getMinutes() -> Int {
        return self.degrees > 0 ? Int(self.minutes): Int(self.minutes) * -1
    }
    
    func getSeconds() -> Int {
        return self.degrees > 0 ? Int(self.seconds): Int(self.seconds) * -1
    }
    
    func getCoord() -> String {
        return "\(self.degrees)°\(self.minutes)′\(self.seconds)″ \(self.getPossition())"
    }
    
    func getCoordDec() -> String {
        return "\(Float(self.degrees) + Float(self.getMinutes()) / 60 + Float(self.getSeconds()) / 3600) \(self.getPossition())"
    }
    
    func middleCoord(newCoord: CoordinateAB) -> CoordinateAB? {
        if newCoord.direction != self.direction{
            return nil
        }
        return CoordinateAB(direction: self.direction,
                            degrees: Int((self.degrees + newCoord.degrees) / 2),
                            minutes: UInt((self.getMinutes() + Int(newCoord.getMinutes())) / 2),
                            seconds: UInt((self.getSeconds() + Int(newCoord.getSeconds())) / 2))
    }
    
    func middleCoordTwo(coord1: CoordinateAB, coord2: CoordinateAB) -> CoordinateAB? {
        if coord1.direction != coord2.direction{
            return nil
        }
        return CoordinateAB(direction: coord1.direction,
                            degrees: Int((coord1.degrees + coord2.degrees) / 2),
                            minutes: UInt((coord1.getMinutes() + Int(coord2.getMinutes())) / 2),
                            seconds: UInt((coord1.getSeconds() + Int(coord2.getSeconds())) / 2))
    }
}


var coord1 = CoordinateAB(direction: .Longtitude, degrees: 28, minutes: 40, seconds: 41)
var coord2 = CoordinateAB()
coord2.setCoords(direction: .Longtitude, degrees: -10, minutes: 15, seconds: 20)
var coord3 = CoordinateAB()
coord3.setDefault()
var coord4 = CoordinateAB(direction: .Latitude, degrees: 23, minutes: 40, seconds: 41)
var coord5 = CoordinateAB(direction: .Latitude, degrees: -28, minutes: 31, seconds: 40)

print()
print("Вивід градусів у звичайному форматі")
print(coord1.getCoord())
print("Вивід градусів у десятковому форматі")
print(coord1.getCoordDec())
print()

print("Вивід градусів у звичайному форматі")
print(coord2.getCoord())
print("Вивід градусів у десятковому форматі")
print(coord2.getCoordDec())
print()

print("Вивід градусів у звичайному форматі")
print(coord3.getCoord())
print("Вивід градусів у десятковому форматі")
print(coord3.getCoordDec())
print()

print("Вивід градусів у звичайному форматі")
print(coord4.getCoord())
print("Вивід градусів у десятковому форматі")
print(coord4.getCoordDec())

print()
print()
print("Вивід середньої кординати між заданою і поточною коли однакові напрямки")
print(coord1.middleCoord(newCoord: coord2)?.getCoord() ?? "")
print()
print("Вивід середньої кординати між заданою і поточною коли різні напрямки")
print(coord1.middleCoord(newCoord: coord3)?.getCoord())
print()
print("Вивід середньої кординати між заданими і поточною коли однакові напрямки")
print(coord1.middleCoordTwo(coord1: coord1, coord2: coord2)?.getCoord() ?? "")
print()
print("Вивід середньої кординати між заданими коли різні напрямки")
print(coord1.middleCoordTwo(coord1: coord2, coord2: coord4)?.getCoord())
