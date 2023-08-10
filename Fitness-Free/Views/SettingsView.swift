//
//  SettingsView.swift
//  Personal Fitness Free
//
//  Created by Conner Stoebe on 5/31/23.
//

import SwiftUI


struct SettingsView: View {
    @ObservedObject var userManager: UserManager
    @State private var notificationsEnabled = true
    @State private var fitnessGoal = 1
    @State private var accountEmail = "user@example.com"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ACCOUNT")) {
                    TextField("Email", text: $accountEmail)
                    Button("Change Password") {
                        // Handle password change
                    }
                    Button("Logout") {
                        // Handle logout
                    }
                }
                
                Section(header: Text("NOTIFICATIONS")) {
                    Toggle("Enabled", isOn: $notificationsEnabled)
                }
                
                Section(header: Text("FITNESS")) {
                    Picker("Fitness Goal", selection: $fitnessGoal) {
                        Text("Lose Weight").tag(1)
                        Text("Build Muscle").tag(2)
                        Text("Improve Endurance").tag(3)
                        Text("Increase Flexibility").tag(4)
                    }
                }
                
                Section(header: Text("LEGAL")) {
                    NavigationLink("Privacy Policy", destination: Text("Privacy Policy Content"))
                    NavigationLink("Terms of Use", destination: Text("Terms of Use Content"))
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(userManager: UserManager.shared)
    }
}
