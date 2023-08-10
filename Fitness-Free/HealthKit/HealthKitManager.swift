//
//  HealthKitManager.swift
//  Personal Fitness Free
//  Created by Conner Stoebe on 5/31/23.

import SwiftUI
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        // startDate keeps track of step data for a week (-7) or (-1) for daily
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let daily = DateComponents(day: 1)
        let anchorDate = Date.mondayAt12AM()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query?.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        // executing query
        if let healthStore = healthStore {
            healthStore.execute(query!)
        }
    }
    
    func getHeartRate(completion: @escaping (HKStatisticsCollection?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let daily = DateComponents(day: 1)
        let anchorDate = Date.mondayAt12AM()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: tomorrow, options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query?.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        // executing query
        if let healthStore = healthStore {
            healthStore.execute(query!)
        }
    }
    
    func getDistanceWalked(completion: @escaping (HKStatisticsCollection?) -> Void) {
        guard let distanceWalkedType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else { return }
        
        // function for calculating distanced walked / ran
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let daily = DateComponents(day: 1)
        let anchorDate = Date.mondayAt12AM()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: tomorrow, options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: distanceWalkedType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query?.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        // executing query
        if let healthStore = healthStore {
            healthStore.execute(query!)
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
              let caloriesType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned),
              let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            return completion(false)
        }
        
        // specifically asking for access to step count, distance walked, calories, and heart rate
        let readTypes: Set<HKObjectType> = [stepType, distanceType, caloriesType, heartRateType]
        
        healthStore?.requestAuthorization(toShare: nil, read: readTypes) { (success, error) in
            completion(success)
        }
    } // end of request authorization
}
