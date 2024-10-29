//
//  Ability.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import Foundation

struct AbilitySet: Codable, Identifiable {
    let id = UUID().uuidString
    var ability: AbilityDetail
    
    struct AbilityDetail: Codable {
        var name: String
        var url: String
    }
    
    enum CodingKeys: CodingKey { // ignore the ID property when decoding
        case ability
    }
}
