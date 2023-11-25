//
//  HabitsDataBinding.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-11-07.
//

import Foundation

class HabitsDataBinding: ObservableObject {
    @Published var _arrHabits: [Int]
    let reminders = ReminderJobs().jobs

    init(arrHabits: [Int]) {
        self._arrHabits = arrHabits
    }
    
    var arrHabits:[Int]{
        get{
            return _arrHabits
        }
    }
    func retrieveItem(id: Int) -> String{
        let english = reminders[id].1
        let chinese = reminders[id].0
        return english
    }
    func setValue(num: Int, setVal:Int){
        _arrHabits[num] = setVal

    }
    

    func display() -> String {
        var s:String = "5️⃣This is Habits Data binding => \(_arrHabits)"
        return s
    }
    
    
}
