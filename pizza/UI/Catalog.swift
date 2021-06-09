//
//  Catalog.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI
import Combine


struct Catalog:View {
    @State var term:String = ""
    @State var lastTerm:String = ""
    @State var pizzas:[Products.Pizza] = []
    @State var searchpizzas:[Products.Pizza] = []
    @State var buy:Bool = false
    var products = Products()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                ZStack {
                    Color.white.cornerRadius(10).frame(height: 40)
                    
                    if term.isEmpty {
                        HStack {
                            Text("Search")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 17))
                                .foregroundColor(.gray)
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    TextField("", text: self.$term)
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(height: 20)
                        .padding(10)
                        .onReceive(Just(term)) { (newValue:String) in
                            if self.term != self.lastTerm
                            {
                                let filtered:[Products.Pizza] = pizzas.filter { term in
                                    return term.name.contains(self.term)
                                }
                                
                                self.searchpizzas = filtered
                                self.lastTerm = self.term
                            }
                        }
                }
                
                ScrollView(.vertical) {
                    HStack {
                        Text("Escolha seu sabor")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        ForEach(0..<self.pizzas.count, id: \.self) { i in
                            NavigationLink(destination: ItemDetail(item: self.$pizzas[i], buy: self.$buy)) {
                                Item(item: self.$pizzas[i])
                            }
                        }
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 100)
            .padding(.horizontal, 20)
            .edgesIgnoringSafeArea([.top, .bottom])
            .background(Color("Color-Escolha"))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .onAppear {
                if self.pizzas.count == 0
                {
                    products.GetPizzas { completion in
                        self.pizzas = completion
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(self.buy ? Color.white : Color.black)
        .background(Color(hex: "#181818"))
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct Item:View {
    @Binding var item:Products.Pizza
    
    var body: some View {
        HStack(spacing: 8) {
            if item.image != Data()
            {
                dataImage(image: item.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width - 40) / 2, height: 106)
            }
            else
            {
                ProgressView()
                    .frame(width: (UIScreen.main.bounds.width - 40) / 2, height: 106)
            }
            
            VStack(alignment:.leading) {
                Text(item.name)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                VStack(alignment:.leading) {
                    Text("a partir de")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                    Text("\(formatNumber(number: item.priceP)!)")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                HStack(spacing:3) {
                    Spacer()
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
                }
            }
            .padding(.vertical, 10)
            .padding(.trailing, 8)
            
            Spacer(minLength: 0)
        }
        .background(Color("Color-Item"))
        .cornerRadius(10)
        .frame(width:UIScreen.main.bounds.width - 40, height: 106)
        .onAppear {
            do {
                print(item.imageURL)
                item.image = try GetImagem(url: item.imageURL)
            }
            catch {
                
            }
        }
    }
}
