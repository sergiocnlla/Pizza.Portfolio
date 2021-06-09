//
//  Success.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI

struct Success:View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Text("Compra efetuada com sucesso!")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#F7F7F7"))
                .lineLimit(2)
                .padding(.horizontal, 90)
                .multilineTextAlignment(.center)
            
            Image("checked")
                .resizable()
                .scaledToFit()
                .frame(width: 185, height: 185)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(hex: "#181818"))
        .padding(.bottom, 80)
    }
}
