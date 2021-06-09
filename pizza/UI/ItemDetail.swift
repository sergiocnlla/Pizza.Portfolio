//
//  ItemDetail.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI

struct ItemDetail:View {
    @Binding var item:Products.Pizza
    @Binding var buy:Bool
    @State var size:Int = 1
    
    var body: some View {
        VStack {
            dataImage(image: item.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
            
            VStack(alignment:.leading, spacing: 20) {
                VStack(alignment:.leading, spacing: 7) {
                    Text(item.name)
                        .font(.system(size: 24))
                        .foregroundColor(Color(hex: "#F7F7F7"))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing:3) {
                        ForEach(0..<5, id:\.self) { i in
                            if i + 1 <= item.rating
                            {
                                Image("star-fill")
                                    .scaledToFit()
                            }
                            else
                            {
                                Image("star")
                                    .scaledToFit()
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                VStack(alignment:.leading, spacing: 7) {
                    Text("Escolha o tamanho")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "#F7F7F7"))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Button(action: {
                            withAnimation() {
                                self.size = 1
                            }
                        }) {
                            Text("P")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(self.size == 1 ? .white : .black)
                                .frame(width: 80, height: 46)
                        }
                        .frame(width: 80, height: 46)
                        .background(self.size == 1 ? Color("Color-Green") : Color(hex:"#F2F2F2"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation() {
                                self.size = 2
                            }
                        }) {
                            Text("M")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(self.size == 2 ? .white : .black)
                                .frame(width: 80, height: 46)
                        }
                        .frame(width: 80, height: 46)
                        .background(self.size == 2 ? Color("Color-Green") : Color(hex:"#F2F2F2"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation() {
                                self.size = 3
                            }
                        }) {
                            Text("G")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(self.size == 3 ? .white : .black)
                                .frame(width: 80, height: 46)
                        }
                        .frame(width: 80, height: 46)
                        .background(self.size == 3 ? Color("Color-Green") : Color(hex:"#F2F2F2"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                
                HStack {
                    Spacer()
                    if self.size == 1
                    {
                        Text("\(formatNumber(number: item.priceP)!)")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "#F7F7F7"))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 22)
                    }
                    else if self.size == 2
                    {
                        Text("\(formatNumber(number: item.priceM)!)")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "#F7F7F7"))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 22)
                    }
                    else
                    {
                        Text("\(formatNumber(number: item.priceG)!)")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "#F7F7F7"))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 22)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            
            Spacer(minLength: 0)
            
            NavigationLink(destination:Success().background(Color(hex: "#181818")), isActive: self.$buy) {
                VStack {
                    Text("Comprar")
                        .font(.system(size: 26))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer(minLength: 0)
                }
                .frame(width: UIScreen.main.bounds.width, height: 160)
                .background(Color("Color-Green"))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("Color-Background"))
    }
}
