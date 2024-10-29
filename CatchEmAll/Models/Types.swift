//
//  Types.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import Foundation

struct Types: Codable, Identifiable {
    let id = UUID().uuidString
    var type: PokeType
    
    struct PokeType: Codable {
        var name: String
    }
    
    enum CodingKeys: CodingKey { // ignore the ID property when decoding
        case type
    }
}
