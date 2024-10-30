//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/19/24.
//

import SwiftUI

struct CreaturesListView: View {
    @State var creatures = Creatures()
    @State private var searchText = ""
    static var defaultFontFamily: String { return "Avenir Next Condensed" }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(searchResults) { creature in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creature)
                        } label: {
                            Text("\(returnIndex(of: creature)). ")
                            Text(creature.name.capitalized)
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                    }
                    .task {
                        await creatures.loadNextIfNeeded(creature: creature)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(creatures.creaturesArray.count) of \(creatures.count) creatures")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await creatures.loadAll()
                            }
                        }
                        .foregroundStyle(.pokemon)
                    }
                }
                .searchable(text: $searchText)
            
                if creatures.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }
                
                Image("pokeball")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.05)
                
                Image("pokemon-logo")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.05)
            }
        }
        .task {
            await creatures.getData()
        }
    }
    
    var searchResults: [Creature] {
        if searchText.isEmpty {
            return creatures.creaturesArray
        } else { // we have some searchText
            return creatures.creaturesArray.filter {$0.name.capitalized.contains(searchText)}
        }
    }
    
    func returnIndex(of creature: Creature) -> Int {
        guard let index = creatures.creaturesArray.firstIndex(where: { $0.id == creature.id }) else {return 0}
        return index + 1
    }
}

#Preview {
    CreaturesListView()
}
