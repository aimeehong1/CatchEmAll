//
//  Abilities.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import Foundation

@Observable // will watch objects for changes so that SwiftUI will redraw the interface when needed
class Abilities {
    private struct Returned: Codable {
        var next: String?
        var ability: [AbilitySet]
    }
    
    var urlString = "Ability(ability: Ability.AbilityDetail)"
    var abilityEffect = ""
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: could not decode returned JSON data")
                return
            }
            Task { @MainActor in
                self.urlString = returned.next ?? ""
//                self.abilityEffect = returned.ability
            }
        } catch {
            print("😡 ERROR: could not get data from \(urlString)")
        }
    }
}
