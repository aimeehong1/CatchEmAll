//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/19/24.
//

import SwiftUI

struct CreaturesListView: View {
    @State var creatures = Creatures()
    
    
    var body: some View {
        NavigationStack {
            List(creatures.creaturesArray, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            
        }
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
