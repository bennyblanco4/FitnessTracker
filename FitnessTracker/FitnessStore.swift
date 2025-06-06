import Foundation
import Combine

class FitnessStore: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var dailySteps: Int = 0
    @Published var dailyCaloriesBurned: Double = 0
    @Published var weeklyGoal: Int = 5 // workouts per week
    @Published var calorieGoal: Double = 500 // daily calories
    @Published var userProfile = UserProfile()
    
    init() {
        loadSampleData()
    }
    
    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
        dailyCaloriesBurned += workout.caloriesBurned
    }
    
    func deleteWorkout(at indexSet: IndexSet) {
        for index in indexSet {
            dailyCaloriesBurned -= workouts[index].caloriesBurned
        }
        workouts.remove(atOffsets: indexSet)
    }
    
    func updateSteps(_ steps: Int) {
        dailySteps = steps
        // Roughly calculate calories from steps (very simplified)
        let caloriesFromSteps = Double(steps) * 0.04
        dailyCaloriesBurned += caloriesFromSteps
    }
    
    // Sample data for preview
    private func loadSampleData() {
        let calendar = Calendar.current
        let today = Date()
        
        let workouts = [
            Workout(type: .running, duration: 30 * 60, caloriesBurned: 350, date: calendar.date(byAdding: .day, value: -1, to: today)!),
            Workout(type: .weightTraining, duration: 45 * 60, caloriesBurned: 280, date: calendar.date(byAdding: .day, value: -2, to: today)!),
            Workout(type: .cycling, duration: 60 * 60, caloriesBurned: 450, date: calendar.date(byAdding: .day, value: -3, to: today)!),
            Workout(type: .yoga, duration: 40 * 60, caloriesBurned: 180, date: today)
        ]
        
        self.workouts = workouts
        self.dailySteps = 8432
        self.dailyCaloriesBurned = 420
    }
}