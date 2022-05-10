//
//  CosmeticsTypyView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 26.04.2022.
//

import SwiftUI

struct CosmeticsTypeFilter: View {
    let types: [Cosmetics.Types.RawValue]
    @Binding var sortSelection: Cosmetics.Types
    
    var localizedTypes: [String] {
        var results = [String]()
        
        for type in types {
            switch type {
            case Cosmetics.Types.spray.rawValue:
                results.append("spray-type")
            case Cosmetics.Types.backpack.rawValue:
                results.append("backpack-type")
            case Cosmetics.Types.glider.rawValue:
                results.append("glider-type")
            case Cosmetics.Types.outfit.rawValue:
                results.append("outfit-type")
            case Cosmetics.Types.music.rawValue:
                results.append("music-type")
            case Cosmetics.Types.wrap.rawValue:
                results.append("wrap-type")
            case Cosmetics.Types.emote.rawValue:
                results.append("emote-type")
            case Cosmetics.Types.contrail.rawValue:
                results.append("contrail-type")
            case Cosmetics.Types.pickaxe.rawValue:
                results.append("pickaxe-type")
            case Cosmetics.Types.loadingscreen.rawValue:
                results.append("loadingscreen-type")
            case Cosmetics.Types.all.rawValue:
                results.append("all-type")
            default:
                results.append("unknown-type")
            }
        }
                
        return results
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<types.count, id: \.self) { index in
                    Text(LocalizedStringKey(localizedTypes[index]))
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(sortSelection.rawValue == types[index] ? Color("Dark") : .secondary)
                        .background(sortSelection.rawValue == types[index]  ? Color("Yellow") : Color("Light"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            sortSelection = Cosmetics.Types(rawValue: types[index]) ?? .all
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CosmeticsTypyView_Previews: PreviewProvider {
    @State static var sort: Cosmetics.Types = .all
    
    static var previews: some View {
        CosmeticsTypeFilter(types: ["all", "spray", "backpack", "glider", "outfit", "music", "wrap", "emote", "contrail", "pickaxe", "loadingscreen"], sortSelection: $sort)
            .preferredColorScheme(.dark)
    }
}
