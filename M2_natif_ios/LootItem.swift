//
//  LootItem.swift
//  M2_natif_ios
//
//  Created by FLEURY on 13/11/2024.
//

import SwiftUICore

enum ItemType: String, CaseIterable {
    case magic = "⭐️"
    case fire = "🔥"
    case ice = "❄️"
    case wind = "💨"
    case poison = "☠️"
    case thunder = "⚡️"
    case dagger = "🗡️"
    case shield = "🛡️"
    case bow = "🏹"
    case ring = "💍"
    case unknown = "🎲"
}

struct LootItem: Identifiable, Hashable {
    
    var quantity: Int = 1 // Valeur par défaut de 1
    var id: UUID = UUID()
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int? // Optionnel
    var game: Game
    
    var body: some View {
        VStack {
            
        }

    }
}
