//
//  PetView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI

struct PetView: View {
    var body: some View {
        GroupBox{
            VStack{
                Text("scottie")
                    .font(
                        Font.custom(
                            "Jua-Regular",
                            size: 20))
                
                Image("CatNeutralImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 150)
            }
            .padding(10)
        }
        .padding(10)
        
    }
}

#Preview {
    PetView()
}
