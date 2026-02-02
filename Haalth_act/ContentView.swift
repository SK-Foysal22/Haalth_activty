//
//  ContentView.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 27/01/2026.
//

import SwiftUI
import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if HealthManager.shared.isHealthDataAvailable() {
            HealthManager.shared.requestAuthorization { (success) in
                if success {
                    self.loadSteps()
                } else {
                    print("Permission Denied")
                }
                }
                
            }
        }
    func loadSteps() {
        HealthManager.shared.getTodaysStepCount { (steps) in
            print("Today's Steps: \(steps)")
        }
    }
}

/*struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, SK!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}*/
