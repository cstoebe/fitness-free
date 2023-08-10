//
//  Personal_Fitness_FreeApp.swift
//  Personal Fitness Free
//
//  Created by Conner Stoebe on 5/29/23.
// this is the main structure fyi

import SwiftUI

@main
struct Personal_Fitness_FreeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserManager.shared)
        }
    }
}
