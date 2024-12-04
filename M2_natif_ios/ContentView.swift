//
//  ContentView.swift
//  M2_natif_ios
//
//  Created by FLEURY on 08/10/2024.
//

import SwiftUI

class Inventory: ObservableObject {
    @Published var loot: [LootItem] = [
        LootItem(quantity: 2, name: "Epée magique", type: .magic, rarity: .common, attackStrength: 5, game: Game(name: "Elden Ring", genre: .rpg, coverName: "eldenring")),
        LootItem(quantity: 1, name: "Bouclier en fer", type: .shield, rarity: .uncommon, attackStrength: nil, game: Game(name: "Skyrim", genre: .rpg, coverName: "skyrim")),
        LootItem(quantity: 4, name: "Armure de glace", type: .ice, rarity: .rare, attackStrength: 10, game: Game(name: "WoW", genre: .mmorpg, coverName: "WoW")),
        LootItem(quantity: 2, name: "Arc en bois", type: .bow, rarity: .epic, attackStrength: 15, game: Game(name: "Diablo IV", genre: .looter, coverName: "diablo")),
        LootItem(quantity: 10, name: "Anneau magique", type: .ring, rarity: .legendary, attackStrength: nil, game: Game(name: "Skyrim", genre: .rpg, coverName: "skyrim")),
        LootItem(quantity: 10, name: "Arc Antique", type: .bow, rarity: .unique, attackStrength: nil, game: Game(name: "Skyrim", genre: .rpg, coverName: "skyrim"))
    ]
    
    func addItem(item: LootItem) {
        loot.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State var showAddItemView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(inventory.loot) { item in
                    NavigationLink(destination: LootDetailView(item: item)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(item.rarity.color)
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text(item.type.rawValue)
                            }
                            HStack {
                                Text("Quantité : \(item.quantity)")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Inventaire")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                    Button(action: {
                        showAddItemView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAddItemView) {
                AddItemView()
                    .environmentObject(inventory)
            }
        }
    }
}

#Preview {
    ContentView()
}
