//
//  StreakModel.swift
//  Rivet
//
//  Created by yessa on 5/22/26.
//

import Foundation
import SwiftData

@Model
final class Streak: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var pomodoroCount: Int
    
    init(date: Date = Calendar.current.startOfDay(for: Date.now), count: Int = 0) {
        self.date = date
        self.pomodoroCount = count
    }
}
