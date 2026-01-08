import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ManipulatorAIViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            HomeView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Analyze")
                }
                .tag(0)
            
            // Learn Tab
            LearnView()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Learn")
                }
                .tag(1)
            
            // History Tab
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
                .tag(2)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(Color("PrimaryBlue"))
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}