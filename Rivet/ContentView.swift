//
//  ContentView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack{
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
                        Text("13d")
                            .font(
                                Font.custom(
                                    "Jua-Regular",
                                    size: 12))
                            .foregroundStyle(.orange)
                    }
                    .padding(.horizontal, 5)
                }
                
            }
            
            HStack{
                
                PetView()
                PomodoroView()
            }
        }
        .padding(10)
        .frame(width: 260)
    }
}

#Preview {
    ContentView()
    
}
