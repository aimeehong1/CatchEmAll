//
//  AbilityDetail.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/29/24.
//

import Foundation

@Observable // will watch objects for changes so that SwiftUI will redraw the interface when needed
class AbilityDetail {
    private struct Returned: Codable {
        var effect_entries: [Effect]
    }
    
    var effectArray: [Effect] = []
    var urlString = ""
    
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
                self.effectArray = returned.effect_entries
            }
        } catch {
            print("😡 ERROR: could not get data from \(urlString)")
        }
    }
}
