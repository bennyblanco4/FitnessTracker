import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var fitnessStore: FitnessStore
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Daily summary card
                    DailySummaryCard(
                        steps: fitnessStore.dailySteps,
                        calories: fitnessStore.dailyCaloriesBurned,
                        calorieGoal: fitnessStore.calorieGoal
                    )
                    
                    // Weekly progress
                    WeeklyProgressView(
                        completedWorkouts: fitnessStore.workouts.count,
                        weeklyGoal: fitnessStore.weeklyGoal
                    )
                    
                    // Recent workouts
                    RecentWorkoutsView(workouts: fitnessStore.workouts.prefix(3).map { $0 })
                    
                    // Quick add workout button
                    Button(action: {
                        // Action to add workout quickly
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Quick Add Workout")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("Fitness Dashboard")
        }
    }
}

struct DailySummaryCard: View {
    let steps: Int
    let calories: Double
    let calorieGoal: Double
    
    var body: some View {
        VStack {
            Text("Today's Summary")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 20) {
                // Steps
                VStack {
                    Image(systemName: "shoe.fill")
                        .font(.system(size: 30))
                    Text("\(steps)")
                        .font(.title2)
                        .bold()
                    Text("Steps")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                
                // Calories
                VStack {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.orange)
                    Text("\(Int(calories))")
                        .font(.title2)
                        .bold()
                    Text("Calories")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                
                // Progress to goal
                VStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 8.0)
                            .opacity(0.3)
                            .foregroundColor(Color.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: min(CGFloat(calories / calorieGoal), 1.0))
                            .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.blue)
                            .rotationEffect(Angle(degrees: 270.0))
                        
                        Text("\(Int(min(calories / calorieGoal * 100, 100)))%")
                            .font(.caption)
                            .bold()
                    }
                    .frame(width: 60, height: 60)
                    
                    Text("Goal")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

struct WeeklyProgressView: View {
    let completedWorkouts: Int
    let weeklyGoal: Int
    
    var body: some View {
        VStack {
            Text("Weekly Goal Progress")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ForEach(0..<weeklyGoal, id: \.self) { index in
                    Circle()
                        .frame(height: 30)
                        .foregroundColor(index < completedWorkouts ? .green : .gray.opacity(0.3))
                }
            }
            .padding()
            
            Text("\(completedWorkouts)/\(weeklyGoal) workouts completed")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct RecentWorkoutsView: View {
    let workouts: [Workout]
    
    var body: some View {
        VStack {
            Text("Recent Workouts")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if workouts.isEmpty {
                Text("No recent workouts")
                    .italic()
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(workouts) { workout in
                    HStack {
                        Image(systemName: workout.type.icon)
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text(workout.type.rawValue.capitalized)
                                .font(.headline)
                            Text("\(Int(workout.duration / 60)) minutes • \(Int(workout.caloriesBurned)) calories")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(workout.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    
                    if workout.id != workouts.last?.id {
                        Divider()
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(FitnessStore())
    }
}