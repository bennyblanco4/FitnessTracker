import Foundation

struct UserProfile: Codable {
    var name: String = "Fitness User"
    var age: Int = 30
    var weight: Double = 70.0 // kg
    var height: Double = 175.0 // cm
    var gender: Gender = .notSpecified
    
    enum Gender: String, Codable, CaseIterable {
        case male
        case female
        case nonBinary
        case notSpecified
    }
    
    var bmi: Double {
        let heightInMeters = height / 100
        return weight / (heightInMeters * heightInMeters)
    }
    
    var bmiCategory: String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<25:
            return "Normal"
        case 25..<30:
            return "Overweight"
        default:
            return "Obese"
        }
    }
}