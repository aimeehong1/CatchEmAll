//
//  AbilityView.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import SwiftUI

struct AbilityView: View {
    @State var ability: AbilitySet.AbilityDetail
    static var defaultFontFamily: String { return "Avenir Next Condensed" }
    
    var body: some View {
        ZStack {
            Image("pika")
                .resizable()
                .scaledToFit()
                .scaleEffect(2)
                .opacity(0.25)
            
            Text("[Effect Description]")
                .font(.title)
        }
    }
}

#Preview {
    AbilityView(ability: AbilitySet.AbilityDetail(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/"))
}
