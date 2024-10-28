//
//  AbilityView.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import SwiftUI

struct AbilityView: View {
    let ability: AbilitySet.AbilityDetail
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    AbilityView(ability: AbilitySet.AbilityDetail(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/"))
}
