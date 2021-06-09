//
//  Login.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI
import AVFoundation
import Combine

struct Login:View {
    
    @Binding var authenticated:Bool
    @State var email:String = ""
    @State var password:String = ""
    @State var loading:Bool = false
    var auth = Auth()
    
    var body: some View {
        VStack(spacing: 12.5) {
            ZStack {
                Color.white.frame(width:UIScreen.main.bounds.width, height: 325)
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 297, height: 176)
            }
            .frame(width:UIScreen.main.bounds.width, height: 325)
            
            VStack(spacing: 20) {
                HStack {
                    Text("Entrar")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                ZStack {
                    Color.white.cornerRadius(8).frame(height: 50)
                    
                    if email.isEmpty {
                        HStack {
                            Text("usuário")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    TextField("", text: self.$email)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(height: 20)
                        .padding(10)
                        .onReceive(Just(email)) { (newValue:String) in
                            self.email = newValue.lowercased()
                        }
                }
                
                ZStack {
                    Color.white.cornerRadius(8).frame(height: 50)
                    
                    if password.isEmpty {
                        HStack {
                            Text("senha")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    SecureField("", text: self.$password)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(height: 20)
                        .padding(10)
                }
                
                Button(action: {
                    withAnimation() {
                        self.loading = true
                    }
                    
                    auth.SignIn(email:self.email, password:self.password) { completion in
                        print(completion)
                        withAnimation() {
                            self.loading = false
                        }
                        
                        if completion.accessToken != ""
                        {
                            withAnimation() {
                                self.authenticated = true
                            }
                        }
                        else
                        {
                            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                            }
                        }
                    }
                }) {
                    if self.loading
                    {
                        ProgressView()
                            .progressViewStyle(DarkBlueShadowProgressViewStyle())
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    else
                    {
                        Text("Entrar")
                            .font(.system(size: 26))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 1.5, height: 60)
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.5, height: 60)
                .background(Color("Color-Green"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 30)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Spacer(minLength: 0)
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(Color("Color-Background"))
    }
}

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6), radius: 4.0, x: 1.0, y: 2.0)
    }
}
