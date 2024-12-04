import SwiftUI

enum Rarity: String, CaseIterable {
    case common
    case uncommon
    case rare
    case epic
    case legendary
    case unique
    
        var color: Color {
            switch self {
            case .common:
                return Color.gray
            case .uncommon:
                return Color.green
            case .rare:
                return Color.blue
            case .epic:
                return Color.purple
            case .legendary:
                return Color.orange
            case .unique:
                return Color.red
            }
        }
}

// AddItemView.swift
import SwiftUI

struct AddItemView: View {
    @State private var name: String = ""
    @State private var rarity: Rarity = .common
    @State private var type: ItemType = .magic
    @State private var attackStrength: Int?
    @State private var attackStrengthButton = false
    @State private var game: Game = Game.emptyGame
    @State private var numberGame: Int = 1

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var inventory: Inventory
    
    var body: some View {
        VStack {
            HStack {
                Text("Ajouter un loot")
                    .bold()
                    .padding()
            }
            Form {
                Section {
                    TextField("Nom de l'objet", text: $name)
                    Picker("Rareté", selection: $rarity) {
                        ForEach(Rarity.allCases, id: \.self) { rarity in
                            Text(rarity.rawValue.capitalized)
                        }
                    }
                }
                
                Section {
                    Picker("Jeu", selection: $game) {
                        Text("Non spécifié").tag(Game.emptyGame)
                        ForEach(availableGames, id: \.id) { game in
                            Text(game.name).tag(game)
                        }
                    }
                    Stepper("Combien : \(numberGame)", value: $numberGame, in: 1...20)
                    
                }
                
                Section {
                    Text("Type sélectionné : \(type.rawValue)")
                    Picker("Type", selection: $type) {
                        ForEach(ItemType.allCases, id: \.self) { itemType in
                            Text(itemType.rawValue).tag(itemType)
                        }
                    }.pickerStyle(.palette)
                    
                }
                
                Section {
                    Toggle("Item d'attaque ?", isOn: $attackStrengthButton)
                        .toggleStyle(.switch)
                    if(attackStrengthButton){
                        Stepper("Force d'attaque : \(attackStrength ?? 1)", value: Binding(
                                    get: { attackStrength ?? 1 },
                                    set: { attackStrength = $0 }
                                ), in: 1...20)
                    }
                }
                
                Section {
                    Button(action: {
                        
                        let attackValue = attackStrengthButton ? attackStrength : nil
                        let newItem = LootItem(
                            quantity: numberGame,
                            name: name,
                            type: type,
                            rarity: rarity,
                            attackStrength: attackValue,
                            game: game
                        )
                        
                        
                        inventory.addItem(item: newItem)
                        
                        
                        dismiss()
                    }) {
                        Text("Ajouter")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Ajouter un item")
    }
}

#Preview {
    AddItemView()
}
