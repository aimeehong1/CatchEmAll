//
//  CreatureDetail.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/19/24.
//

import Foundation

@Observable // will watch objects for changes so that SwiftUI will redraw the interface when needed
class CreatureDetail: Identifiable {
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
        var types: [Types]
        var abilities: [AbilitySet]
        var base_experience: Int
        var stats: [StatSet]
    }
    
    struct Sprite: Codable {
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String? // this might return null, which is nil in Swift
    }
    
    var urlString = ""
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var abilities: [AbilitySet] = []
    var types: [Types] = []
    var base_experience = 0
    var stats: [StatSet] = []
    
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
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.other.officialArtwork.front_default ?? "n/a"
                self.abilities =  returned.abilities
                self.types = returned.types
                self.base_experience = returned.base_experience
                self.stats = returned.stats
            }
            
        } catch {
            print("😡 ERROR: could not get data from \(urlString)")
        }
    }
}
