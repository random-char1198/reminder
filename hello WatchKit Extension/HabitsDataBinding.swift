//
//  HabitsDataBinding.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-11-07.
//

import Foundation

class HabitsDataBinding: ObservableObject {
    @Published var _arrHabits: [Int]
    
    init(arrHabits: [Int]) {
        self._arrHabits = arrHabits
    }
    
    var arrHabits:[Int]{
        get{
            return _arrHabits
        }
    }
    func setValue(num: Int, setVal:Int){
        _arrHabits[num] = setVal

    }
    func display() -> String {
        var s:String = "5️⃣This is Habits Data binding => \(_arrHabits)"
        return s
    }
    
    
}
