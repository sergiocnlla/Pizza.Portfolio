//
//  App.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI

struct App:View {
    @State var authenticated:Bool = false
    
    var body: some View {
        HStack {
            VStack {
                if !self.authenticated
                {
                    Login(authenticated: self.$authenticated)
                }
                else
                {
                    Catalog()
                }
                
                Spacer(minLength: 0)
            }
            .modifier(DarkModeViewModifier())
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .edgesIgnoringSafeArea(.all)
            
            Spacer(minLength: 0)
        }
    }
}
