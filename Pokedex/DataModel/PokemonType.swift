//
//  PokemonType.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 21/06/25.
//

import UIKit

enum PokemonType: String, Codable {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
    
    func getTitle() -> String {
        return self.rawValue.capitalized
    }
    
    func getColor() -> UIColor {
        switch self {
        case .normal:
            return UIColor(hex: "#A8A77A")
        case .fire:
            return UIColor(hex: "#EE8130")
        case .water:
            return UIColor(hex: "#6390F0")
        case .electric:
            return UIColor(hex: "#F7D02C")
        case .grass:
            return UIColor(hex: "#7AC74C")
        case .ice:
            return UIColor(hex: "#96D9D6")
        case .fighting:
            return UIColor(hex: "#C22E28")
        case .poison:
            return UIColor(hex: "#A33EA1")
        case .ground:
            return UIColor(hex: "#E2BF65")
        case .flying:
            return UIColor(hex: "#A98FF3")
        case .psychic:
            return UIColor(hex: "#F95587")
        case .bug:
            return UIColor(hex: "#A6B91A")
        case .rock:
            return UIColor(hex: "#B6A136")
        case .ghost:
            return UIColor(hex: "#735797")
        case .dragon:
            return UIColor(hex: "#6F35FC")
        case .dark:
            return UIColor(hex: "#705746")
        case .steel:
            return UIColor(hex: "#B7B7CE")
        case .fairy:
            return UIColor(hex: "#D685AD")
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 4), (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
