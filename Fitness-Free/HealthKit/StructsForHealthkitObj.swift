//
//  StructsForHealthkitObj.swift
//  Personal Fitness Free
//
//  Created by Junior Paniagua on 7/17/23.
//

import SwiftUI

struct Step: Identifiable{
    let id = UUID()
    let count: Int
    let date: Date
}

struct HeartRate: Identifiable{
    let id = UUID()
    let count: Int
    let date: Date
}

struct Distance: Identifiable{
    let id = UUID()
    let dist: Int
    let date: Date
}
