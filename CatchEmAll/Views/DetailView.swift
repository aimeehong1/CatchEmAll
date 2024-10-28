//
//  DetailView.swift
//  CatchEmAll
//
//  Created by Aimee Hong on 10/19/24.
//

import SwiftUI
import AVFAudio

struct DetailView: View {
    @State private var audioPlayer: AVAudioPlayer!
    let creature: Creature
    @State private var creatureDetail = CreatureDetail()
    static var defaultFontFamily: String { return "Avenir Next Condensed" }
    
    var body: some View {
        VStack (alignment: .center, spacing: 24) {
            creatureImage
            
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 40))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            HStack {
                Spacer()
                
                Text("Height:")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.red)
                
                Text(String(format: "%.1f", creatureDetail.height))
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Text("Weight:")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.red)
                
                Text(String(format: "%.1f", creatureDetail.weight))
                    .font(.title3)
                    .bold()
                
                Spacer()
            }
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            
            HStack {
                ForEach(creatureDetail.types) { type in
                    let creatureType = type.type.name.capitalized
                    Text("\(creatureType)")
                        .font(.title3)
                        .background(Color("\(creatureType)"))
                        .foregroundStyle(.white)
                        .frame(maxHeight: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            
            List {
                Section(header: Text("Abilities")) {
                    ForEach(creatureDetail.abilities) { ability in
                        Text("\(ability.ability.name.capitalized)")
                    }
                }
                Section(header: Text("Stats")) {
                    ForEach(creatureDetail.stats) { stat in
                        if stat.stat.name == "hp" {
                            HStack {
                                Text(stat.stat.name.uppercased())
                                Spacer()
                                Text("\(stat.baseStat)")
                            }
                        } else {
                            HStack {
                                Text(stat.stat.name.capitalized)
                                Spacer()
                                Text("\(stat.baseStat)")
                            }
                        }
                    }
                }
            }
            .listStyle(.automatic)
        }
        .task {
            creatureDetail.urlString = creature.url // use URL passed over in getDetail CreatureDetail
            await creatureDetail.getData()
        }
    }
}

extension DetailView {
    var creatureImage: some View {
        AsyncImage(url: URL(string: creatureDetail.imageURL)) { phase in
            if let image = phase.image { // we have a valid image
                image
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .frame(width: 240, height: 240)
                
            } else if phase.error != nil { // We've had an error
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .frame(width: 240, height: 240)
            } else { // use a placeholder - image loading
                ProgressView()
                    .tint(.red)
                    .scaleEffect(10)
                    .frame(height: 220)
            }
        }
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioplayer.")
        }
    }
}

#Preview {
    DetailView(creature: Creature(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"))
}
