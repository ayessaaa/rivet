//
//  PomodoroView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI


struct PomodoroView: View {
    
    let start = Date().addingTimeInterval(-30)
    let end = Date().addingTimeInterval(90)
    
    
    var body: some View {
        GroupBox{
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text("Focus")
                    Spacer()
                    Text("1/4")
                        .foregroundStyle(.yellow)
                }
                .frame(width: 115)
                .font(
                    Font.custom(
                        "Jua-Regular",
                        size: 14))
                HStack{
                    ZStack{
                        
                        CircularProgressView(progress: 1, width: 50)
                            .frame(height: 70)
                        Text("25:00")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10))
                            .foregroundStyle(.blue)
                        

                    }
                    Button {
                        // Action here
                    } label: {
                        Label("Start", systemImage: "play.fill")
                    }
                    .labelStyle(.iconOnly)
                    .font(
                        Font.custom(
                            "Jua-Regular",
                            size: 12))
                    
                }
                VStack(alignment: .leading, spacing: -2){
                    HStack{
                        Text("today's pomodoro")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10))
                            .foregroundStyle(.gray)
                            .frame(width: 80)
                        Spacer()
                        Text("5/6")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 10))
                            .foregroundStyle(.orange)
                    }
                    
                    
                    ProgressView(value: 0.3)
                        .frame(width: 115)
                        .tint(.orange)
                }
            }
            .padding(5)
        }
    }
        
}

#Preview {
    PomodoroView()
        .padding()
}
