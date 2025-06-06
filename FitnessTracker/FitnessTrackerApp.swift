import SwiftUI

@main
struct FitnessTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "heart.fill")
                    }
                
                WorkoutListView()
                    .tabItem {
                        Label("Workouts", systemImage: "figure.run")
                    }
                
                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.fill")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .environmentObject(FitnessStore())
        }
    }
}