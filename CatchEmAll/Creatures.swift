//
//  Creatures.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/19/24.
//

import Foundation

@Observable // will watch objects for changes so that SwiftUI will redraw the interface when needed
class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String // TODO: we want to change this to an optional
        var results: [Creature]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon"
    var count = 0
    var creaturesArray: [Creature] = []
    
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
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("😡 ERROR: could not get data from \(urlString)")
        }
    }
}
