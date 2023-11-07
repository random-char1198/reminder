//
//  DataManager.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-11-07.
//

import Foundation

import Combine

class DataManager: ObservableObject{
    @Published var arrHabits:[Int]
    
    init(arrHabits: [Int]) {
        self.arrHabits = arrHabits
    }
}
