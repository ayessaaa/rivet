//
//  PomodoroView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import Combine
import SwiftData
import SwiftUI

struct PomodoroView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Streak.date, order: .forward) var streaks: [Streak]

    private let focusTimes: [Int] = [1 * 10, 1 * 5, 1 * 15]

    private let focusColors: [Color] = [
        Color.yellow, Color.blue, Color.green,
    ]

    private let focusTexts: [String] = [
        "Focus", "Short break", "Long break",
    ]

    @AppStorage("timerType") private var timerType: Int = 0

    @AppStorage("pomodoroCount") private var pomodoroCount: Int = 1
    @AppStorage("timeRemaining") private var timeRemaining: Int = 25 * 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var timerStart = false
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(focusTexts[timerType])
                    Spacer()
                    Text("\(pomodoroCount)/4")
                        .foregroundStyle(.gray)
                }
                .frame(width: 118)
                .font(
                    Font.custom(
                        "Jua-Regular",
                        size: 14
                    )
                )
                HStack {
                    ZStack {
                        let total = Double(focusTimes[timerType])
                        CircularProgressView(
                            progress: total > 0
                                ? Double(timeRemaining) / total : 0,
                            width: 50,
                            color: focusColors[timerType]
                        )
                        .frame(height: 70)
                        let minutes = timeRemaining / 60
                        let seconds = timeRemaining % 60
                        let secondsString = String(format: "%02d", seconds)
                        Text("\(minutes):\(secondsString)")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10
                                )
                            )
                            .foregroundStyle(focusColors[timerType])
                    }
                    VStack(spacing: 5) {
                        Button {
                            timerStart.toggle()
                        } label: {
                            Label(
                                "Start",
                                systemImage: timerStart
                                    ? "pause.fill" : "play.fill"
                            )
                        }
                        .labelStyle(.iconOnly)
                        .font(
                            Font.custom(
                                "Jua-Regular",
                                size: 12
                            )
                        )

                        if timerStart {
                            Button {
                                timerStart = false
                                timeRemaining = focusTimes[timerType]

                            } label: {
                                Label("Start", systemImage: "stop.fill")
                            }
                            .labelStyle(.iconOnly)
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 12
                                )
                            )
                        }

                    }

                }
                VStack(alignment: .leading, spacing: -2) {
                    HStack {
                        Text("today's pomodoro:")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10
                                )
                            )
                            .foregroundStyle(.gray)
                            .frame(width: 85)
                        Spacer()
                        Text("\((streaks.last?.pomodoroCount) ?? 0)/6", )
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10
                                )
                            )
                            .foregroundStyle(.orange)
                    }

                }
                .padding(.top, 5)
                
                
//                List{
//                    ForEach(streaks) {streak in
//                        Text(streak.date, style: .date)
//                        Text(String(streak.pomodoroCount))
//                    }
//                }
            }
            .padding(5)
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 && timerStart {
                timeRemaining -= 1
            }
            if timeRemaining == 0 && timerStart {
                timerStart = false
                if timerType == 0 {
                    if pomodoroCount < 4 {
                        timerType = 1
                        pomodoroCount += 1
                    } else {
                        timerType = 2
                        pomodoroCount = 1
                    }
                    addPomodoroCount()
                } else {
                    timerType = 0
                }
                timeRemaining = focusTimes[timerType]
            }
        }
        .onChange(of: timerType) { _, newValue in
            timeRemaining = focusTimes[newValue]
        }
        .onAppear {
//             resetStreaks() // Uncomment to clear all Streak records on appear
            if timeRemaining <= 0 {
                timeRemaining = focusTimes[timerType]
            }
            addRecord()
            print(streaks)
        }
    }

    func addRecord() {
        let today = Calendar.current.startOfDay(for: Date())

        let mostRecent = streaks
            .map { Calendar.current.startOfDay(for: $0.date) }
            .max() ?? Calendar.current.date(byAdding: .day, value: -1, to: today)!

        var cursor = Calendar.current.date(byAdding: .day, value: 1, to: mostRecent)!

        while cursor <= today {
            let newRecord = Streak(date: cursor)
            modelContext.insert(newRecord)
            cursor = Calendar.current.date(byAdding: .day, value: 1, to: cursor)!
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save streaks: \(error)")
        }
    }
    
    func addPomodoroCount(){
        if let streak = streaks.last{
            streak.pomodoroCount += 1
            try? modelContext.save()
        }
    }
    
    func resetStreaks() {
        do {
            try modelContext.delete(model: Streak.self)
            try modelContext.save()
        } catch {
            print("Failed to reset data: \(error)")
        }
    }
}

#Preview {
    PomodoroView()
        .padding()
}

