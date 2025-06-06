import SwiftUI

struct WorkoutListView: View {
    @EnvironmentObject var fitnessStore: FitnessStore
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fitnessStore.workouts.sorted(by: { $0.date > $1.date })) { workout in
                    WorkoutRow(workout: workout)
                }
                .onDelete(perform: fitnessStore.deleteWorkout)
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddWorkout = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView()
            }
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: workout.type.icon)
                    .font(.system(size: 22))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.type.rawValue.capitalized)
                    .font(.headline)
                
                Text("\(Int(workout.duration / 60)) minutes")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("\(Int(workout.caloriesBurned)) calories")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(workout.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(workout.date, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var fitnessStore: FitnessStore
    
    @State private var selectedType: Workout.WorkoutType = .running
    @State private var duration: Double = 30
    @State private var caloriesBurned: Double = 200
    @State private var date = Date()
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Details")) {
                    Picker("Type", selection: $selectedType) {
                        ForEach(Workout.WorkoutType.allCases, id: \.self) { type in
                            Label(type.rawValue.capitalized, systemImage: type.icon)
                                .tag(type)
                        }
                    }
                    
                    HStack {
                        Text("Duration")
                        Spacer()
                        Text("\(Int(duration)) minutes")
                    }
                    Slider(value: $duration, in: 5...180, step: 5)
                    
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text