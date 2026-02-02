//
//  HealthkitTypes.swift
//  Haalth_act
//
//  Created by Hossain S M F (FCES) on 29/01/2026.
//

import HealthKit

 

// Centralised list of HealthKit types required by the app

enum HealthKitTypes {

     

    static let readTypes: Set<HKObjectType> = [

        HKObjectType.quantityType(forIdentifier: .stepCount)!,

        HKObjectType.quantityType(forIdentifier: .heartRate)!,

        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,

        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!

    ]

} 
