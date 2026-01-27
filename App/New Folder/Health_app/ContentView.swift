//
//  ContentView.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 27/01/2026.
//



import SwiftUI



struct ContentView: View {

    

   @StateObject private var viewModel = ActivityViewModel()

    

   var body: some View {

       NavigationView {

           VStack(spacing: 20) {

               metric("Steps", Int(viewModel.metrics.steps))

               metric("Heart Rate", "\(Int(viewModel.metrics.heartRate)) BPM")

               metric("Distance", String(format: "%.2f m", viewModel.metrics.distance))

               metric("Calories", String(format: "%.1f kcal", viewModel.metrics.calories))

                

               Button("Refresh") {

                   viewModel.refreshData()

               }

               .buttonStyle(.borderedProminent)

           }

           .padding()

           .navigationTitle("Activity Tracker")

       }

       .onAppear {

           viewModel.requestAccess()

       }

   }

    

   private func metric(_ title: String, _ value: Any) -> some View {

       VStack {

           Text(title)

               .font(.headline)

           Text("\(value)")

               .font(.title2)

               .bold()

       }

       .frame(maxWidth: .infinity)

       .padding()

       .background(Color(.secondarySystemBackground))

       .cornerRadius(10)

   }

} 
