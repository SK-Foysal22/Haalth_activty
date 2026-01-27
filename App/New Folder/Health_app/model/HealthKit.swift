//
//  HealthKit.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 29/01/2026.
//




import Foundation

import HealthKit



/// Handles all HealthKit interactions

final class HealthKit {

    

   static let shared = HealthKit()

   private let store = HKHealthStore()

    

   private init() {}

    

   // MARK: - Authorization

    

   func requestAuthorization(completion: @escaping (Bool) -> Void) {

       store.requestAuthorization(

           toShare: [],

           read: HealthKitTypes.readTypes

       ) { success, _ in

           completion(success)

       }

   }

    

   // MARK: - Fetch All Metrics

    

   func fetchTodayMetrics(completion: @escaping (ActivityMetrics) -> Void) {

       var metrics = ActivityMetrics()

       let group = DispatchGroup()

        

       group.enter()

       fetchCumulative(.stepCount, unit: .count()) {

           metrics.steps = $0

           group.leave()

       }

        

       group.enter()

       fetchAverage(.heartRate, unit: HKUnit(from: "count/min")) {

           metrics.heartRate = $0

           group.leave()

       }

        

       group.enter()

       fetchCumulative(.distanceWalkingRunning, unit: .meter()) {

           metrics.distance = $0

           group.leave()

       }

        

       group.enter()

       fetchCumulative(.activeEnergyBurned, unit: .kilocalorie()) {

           metrics.calories = $0

           group.leave()

       }

        

       group.notify(queue: .main) {

           completion(metrics)

       }

   }

    

   // MARK: - Helpers

    

   private func fetchCumulative(

       _ identifier: HKQuantityTypeIdentifier,

       unit: HKUnit,

       completion: @escaping (Double) -> Void

   ) {

       guard let type = HKQuantityType.quantityType(forIdentifier: identifier) else {

           completion(0)

           return

       }

        

       let query = HKStatisticsQuery(

           quantityType: type,

           quantitySamplePredicate: todayPredicate(),

           options: .cumulativeSum

       ) { _, result, _ in

           completion(result?.sumQuantity()?.doubleValue(for: unit) ?? 0)

       }

        

       store.execute(query)

   }

    

   private func fetchAverage(

       _ identifier: HKQuantityTypeIdentifier,

       unit: HKUnit,

       completion: @escaping (Double) -> Void

   ) {

       guard let type = HKQuantityType.quantityType(forIdentifier: identifier) else {

           completion(0)

           return

       }

        

       let query = HKStatisticsQuery(

           quantityType: type,

           quantitySamplePredicate: todayPredicate(),

           options: .discreteAverage

       ) { _, result, _ in

           completion(result?.averageQuantity()?.doubleValue(for: unit) ?? 0)

       }

        

       store.execute(query)

   }

    

   private func todayPredicate() -> NSPredicate {

       let start = Calendar.current.startOfDay(for: Date())

       return HKQuery.predicateForSamples(

           withStart: start,

           end: Date(),

           options: .strictStartDate

       )

   }

}

