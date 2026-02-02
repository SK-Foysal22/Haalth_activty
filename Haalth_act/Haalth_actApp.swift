//
//  Haalth_actApp.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 27/01/2026.
//

import SwiftUI
import HealthKit

class HealthManager {
    ststic let shared = HealthManager()
    let healthStore = HKHealthStore()
    
    //check healthkit avaivility
    func isHealthDataAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    //Permission
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let typesToRead: Set<HKObjectType> = [stepCountType]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            completion(success)
        }
        
    }
    //get recent data
    func getTodaysStepCount(completion: @escaping (Int) -> Void) {
        
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            
            let steps: result?.sumQuantity()?.doubleValue (for: HKUnit.count()) ?? 0
            dispatchQueue.main.async {
                completion(Int(steps))
            }
        }
        healthStore.execute(query)
    }
}
@main
struct Haalth_actApp: App {
    var body: some Scene {
        WindowGroup {
        }
    }
}
