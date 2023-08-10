//
//  DistanceRanWalkedView.swift
//  Personal Fitness Free
//
//  Created by Junior Paniagua on 7/17/23.
//

import SwiftUI
import HealthKit

struct DistanceWalkRunView: View {
    
    private var healthStore: HealthStore?
    @State private var distance: [Distance] = [Distance]()
    
    init(){
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(statisticsCollection: HKStatisticsCollection){
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { ( statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let dist = Distance(dist: Int (count ?? 0), date: statistics.startDate)
            
            distance.append(dist)
        }
    }
    
    
    
    var body: some View {
        List(distance, id: \.id){ distance in
            VStack(alignment: .leading){
                Text("\(distance.dist)" + " miles")
                Text("\(distance.date)")
                    .opacity(0.5)
            }
            .navigationTitle("Distance Walked/ Ran")
        }
        .onAppear{
            if let healthStore = healthStore{
                healthStore.requestAuthorization{ success in
                    if success {
                        healthStore.getDistanceWalked{ statisticsCollection in
                            if let statisticsCollection = statisticsCollection{
                                //update the UI
                                updateUIFromStatistics(statisticsCollection: statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}
                                                      

struct DistanceWalkRunView_Previews: PreviewProvider {
    
    static var previews: some View {
        DistanceWalkRunView()
    }
}
