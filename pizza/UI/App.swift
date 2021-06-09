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
        VStack {
            if !self.authenticated
            {
                Login(authenticated: self.$authenticated)
            }
            else
            {
                Catalog()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
