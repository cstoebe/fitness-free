//
//  ContentView.swift
//  Personal Fitness Free
//
//  Created by Conner Stoebe on 5/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
    
        TabView{
            HomeView()
                .tabItem{
                    Label("Home", systemImage:"house.circle.fill")
                }
            CalendarView()
                .tabItem{
                    Label("Calendar", systemImage:"calendar.circle.fill")
                }
            
            WorkoutView()
                .tabItem{
                    Label("Workout", systemImage:"flame.circle.fill")
                }
            
            ProfileView()
                .tabItem {
                    if let currentUser = UserManager.shared.currentUser,
                        let userImage = UserManager.shared.getProfilePicture(for: currentUser) {
                        Image(uiImage: userImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    else{
                        Image(systemName: "person.circle.fill")
                        }
                    Text("Profile")
                    }
            
            SettingsView(userManager: UserManager.shared)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                                }
        }
        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
