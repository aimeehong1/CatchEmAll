//
//  Stat.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import Foundation

struct StatSet: Codable, Identifiable {
    let id = UUID().uuidString
    var baseStat: Int
    var stat: Stat
    
    struct Stat: Codable {
        var name: String
    }
    
    enum CodingKeys: String, CodingKey { // ignore the ID property when decoding
        case baseStat = "base_stat"
        case stat
    }
}

