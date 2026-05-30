//
//  ContentView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var streakCount = 0
    var body: some View {
        VStack {
            HStack (spacing: 5){
                Text("Rivet")
                    .font( 
                        Font.custom(
                            "Jua-Regular",
                            size: 16))
                    .padding(.leading, 5)
                Spacer()
                GroupBox{
                    HStack(spacing: 5){
                        Image(systemName: "flame.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                            .foregroundStyle(.orange)
                        Text("\(String(streakCount))d")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 12))
                            .foregroundStyle(.orange)
                    }
                    .padding(.horizontal, 5)
                }
                
                Button{
                    
                } label : {
                    Image(systemName: "gearshape.fill")
                }
                
            }
            
            HStack{
                
                PetView()
                PomodoroView( streakCount: $streakCount)
            }
        }
        .padding(10)
        .frame(width: 260)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Streak.self, inMemory: true)
}
