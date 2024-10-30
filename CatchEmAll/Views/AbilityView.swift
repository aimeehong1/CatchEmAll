//
//  AbilityView.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/28/24.
//

import SwiftUI

struct AbilityView: View {
    let pokeAbilitySet: AbilitySet.Ability
    @State var abilityDetail = AbilityDetail()
    
    var body: some View {
        VStack {
            Text(pokeAbilitySet.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 40))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Spacer()
            
            ZStack {
                Image("pika")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(2)
                    .opacity(0.10)
                
                ForEach(abilityDetail.effectArray) { effect in
                    if effect.language.name == "en" {
                        Text(effect.effect)
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .task {
            abilityDetail.urlString = pokeAbilitySet.url
            await abilityDetail.getData()
        }
    }
}

#Preview {
    AbilityView(pokeAbilitySet: AbilitySet.Ability(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/"))
}

