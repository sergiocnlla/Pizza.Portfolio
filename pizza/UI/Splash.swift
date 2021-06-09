//
//  Splash.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI

struct Splash: View {
    var body:some View {
        VStack {
            Image("splash")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
            
            Spacer(minLength: 0)
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(Color("Color-Background"))
    }
}
