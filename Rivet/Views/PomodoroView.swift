//
//  PomodoroView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI
import Combine


struct PomodoroView: View {
    
    private let focusTimes: [TimerType: Int] = [.focus: 1*10, .shortBreak: 1*5, .longBreak: 1*15]
    
    private let focusColors: [TimerType: Color] = [.focus: Color.yellow, .shortBreak: Color.blue, .longBreak: Color.green]
    
    @State private var timerType: TimerType = .focus

    @AppStorage("pomodoroCount") private var pomodoroCount: Int = 1
    @AppStorage("timeRemaining") private var timeRemaining: Int = 25*60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var timerStart = false
    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    Text("Focus")
                    Spacer()
                    Text("\(pomodoroCount)/4")
                        .foregroundStyle(.gray)
                }
                .frame(width: 115)
                .font(
                    Font.custom(
                        "Jua-Regular",
                        size: 14))
                HStack{
                    ZStack{
                        CircularProgressView(progress: (Double(timeRemaining)/Double(focusTimes[timerType] ?? 25*60)), width: 50, color: focusColors[timerType]!)
                            .frame(height: 70)
                        let minutes = timeRemaining / 60
                        let seconds = timeRemaining % 60
                        let secondsString = String(format: "%02d", seconds)
                        Text("\(minutes):\(secondsString)")
                            .onReceive(timer) { _ in
                                if timeRemaining > 0 && timerStart {
                                    timeRemaining -= 1
                                }
                            }
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10))
                            .foregroundStyle(focusColors[timerType]!)
                    }
                    VStack(spacing: 5){
                        Button {
                            timerStart.toggle()
                        } label: {
                            Label("Start", systemImage: timerStart ? "pause.fill" : "play.fill" )
                        }
                        .labelStyle(.iconOnly)
                        .font(
                            Font.custom(
                                "Jua-Regular",
                                size: 12))
                        
                        if timerStart {
                            Button {
                                timerStart = false
                                timeRemaining = focusTimes[timerType] ?? 0
                                
                            } label: {
                                Label("Start", systemImage: "stop.fill" )
                            }
                            .labelStyle(.iconOnly)
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 12))
                        }
                        
                        
                    }
                    
                    
                }
                VStack(alignment: .leading, spacing: -2){
                    HStack{
                        Text("today's pomodoro:")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10))
                            .foregroundStyle(.gray)
                            .frame(width: 85)
                        Spacer()
                        Text("5/6")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10))
                            .foregroundStyle(.orange)
                    }
                    
                    
                }
                .padding(.top, 5)
            }
            .padding(5)
        }
        .onReceive(timer) { _ in
            if timeRemaining == 0 && timerStart {
                timerStart = false
                if timerType == .focus {
                    if pomodoroCount < 4 {
                        timerType = .shortBreak
                        pomodoroCount += 1
                    } else {
                        timerType = .longBreak
                        pomodoroCount = 1
                    }
                } else {
                    timerType = .focus
                }
                timeRemaining = focusTimes[timerType] ?? 25*60
            }
        }
        .onChange(of: timerType) { _, newValue in
            timeRemaining = focusTimes[newValue] ?? 25*60
        }
        .onAppear {
            if timeRemaining <= 0 {
                timeRemaining = focusTimes[timerType] ?? 25*60
            }
        }
    }
    
}

#Preview {
    PomodoroView()
        .padding()
}

