//
//  ActivityViewModel.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 29/01/2026.
//

import Foundation
import Combine

 

/// Connects HealthKit service to the user interface

final class ActivityViewModel: ObservableObject {

     

    @Published private(set) var metrics = ActivityMetrics()

    @Published var authorized = false

     

    private let healthKit = HealthKit.shared

     

    func requestAccess() {

        healthKit.requestAuthorization { [weak self] success in

            DispatchQueue.main.async {

                self?.authorized = success

                if success {

                    self?.refreshData()

                }

            }

        }

    }

     

    func refreshData() {

        healthKit.fetchTodayMetrics { [weak self] metrics in

            self?.metrics = metrics

        }

    }

}
