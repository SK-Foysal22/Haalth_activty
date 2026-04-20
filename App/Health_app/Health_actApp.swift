//
//  Haalth_actApp.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 27/01/2026.
//

import SwiftUI

 

@main

struct Health_actApp: App {
    @StateObject var activityViewModel = ActivityViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: activityViewModel)
        }
    }

}

 
