import Foundation

struct Workout: Identifiable, Codable {
    var id = UUID()
    var type: WorkoutType
    var duration: TimeInterval
    var caloriesBurned: Double
    var date: Date
    var notes: String?
    
    enum WorkoutType: String, Codable, CaseIterable {
        case running
        case walking
        case cycling
        case swimming
        case weightTraining
        case yoga
        case hiit
        
        var icon: String {
            switch self {
            case .running: return "figure.run"
            case .walking: return "figure.walk"
            case .cycling: return "bicycle"
            case .swimming: return "figure.pool.swim"
            case .weightTraining: return "dumbbell.fill"
            case .yoga: return "figure.mind.and.body"
            case .hiit: return "bolt.heart.fill"
            }
        }
    }
}