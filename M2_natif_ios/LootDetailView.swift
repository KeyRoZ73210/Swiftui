//
//  LootDetailView.swift
//  M2_natif_ios
//
//  Created by FLEURY on 13/11/2024.
//

import SwiftUI

struct LootDetailView: View {
    var item: LootItem
    
    @State private var degrees: Double = 0
    
    @State private var shadowRadius:Bool = false
    @State private var isAppeared: Bool = false
    
    @State private var isAnimating = false
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text(item.type.rawValue)
                .font(.system(size: 68))
                .padding()
                .background(
                    Rectangle()
                        .fill(item.rarity.color)
                    .cornerRadius(20)
                ).shadow(color: (item.rarity.color).opacity(0.8), radius: shadowRadius ? 50 : 0, x: 0, y: 0)
                .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 1, z: 0))
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .animation(.easeIn(duration: 1), value: shadowRadius)
                //.rotation3DEffect(.degrees(rotationX), axis: (x: 1, y: 1, z: 0))
                .task {
                    try? await Task.sleep(for: .seconds(0.4))
                    isAppeared = true
                    withAnimation(.spring(duration: 1, bounce: 0.6 )) {
                        self.degrees = 360
                    }
                    try? await Task.sleep(for: .seconds(0.6))
                    isAppeared = true
                    withAnimation(.bouncy(duration: 2)) {
                        shadowRadius = true
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeIn(duration: 1)) {
                        isAnimating.toggle()
                    }
                }
            
                
            Text(item.name)
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
                .foregroundColor(item.rarity.color)
            
            if(item.rarity == .unique){
                Text("Objet Unique 🏆")
                    .background(
                        Rectangle()
                            .fill(item.rarity.color)
                            .frame(width: 350, height: 50)
                        .cornerRadius(10)
                    ).shadow(color: (item.rarity.color).opacity(0.8), radius: 20, x: 0, y: 0)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .padding(50)
                    .animation(
                            Animation.easeOut(duration: 1).repeatForever(autoreverses: false),
                            value: 1
                        )
                /*Button("animated") {
                    withAnimation{
                        self.degrees += 180
                    }
                }*/
            }
            
        }
        
        
        VStack(alignment: .leading, spacing: 10) {
            Text("INFORMATIONS")
                .multilineTextAlignment(.leading)
                .font(.caption)
                .foregroundColor(.gray)
        }
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
    
                if let coverName = item.game.coverName {
                    Image(coverName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                }
                VStack(alignment: .leading) {
                    Text(item.game.name)
                        .font(.headline)
                    Divider()
                    Text("In-game : \(item.name)")
                    Divider()
                    Text("Puissance (ATQ) : \(item.attackStrength ?? 0)")
                    Divider()
                    Text("Possédé(s) : \(item.quantity)")
                    Divider()
                    Text("Rareté : \(item.rarity.rawValue.capitalized)")
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
        
        Spacer()
    }
}

#Preview {
    LootDetailView(item: LootItem(quantity: 1, name: "Exemple", type: .magic, rarity: .rare, attackStrength: 5, game: Game(name: "Exemple Game", genre: .rpg, coverName: nil)))
}
