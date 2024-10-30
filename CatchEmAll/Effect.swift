//
//  Effect.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/29/24.
//

import Foundation


struct Effect: Codable, Identifiable {
    let id = UUID().uuidString
    var effect: String
    var language: Language

    struct Language: Codable {
        var name: String
    }
    
    enum CodingKeys: CodingKey { // ignore the ID property when decoding
        case effect
        case language
    }
}
