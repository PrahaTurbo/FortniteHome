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
                results.append("Граффити")
            case Cosmetics.Types.backpack.rawValue:
                results.append("Украшение на спину")
            case Cosmetics.Types.glider.rawValue:
                results.append("Дельтаплан")
            case Cosmetics.Types.outfit.rawValue:
                results.append("Экипировка")
            case Cosmetics.Types.music.rawValue:
                results.append("Музыка")
            case Cosmetics.Types.wrap.rawValue:
                results.append("Обёртка")
            case Cosmetics.Types.emote.rawValue:
                results.append("Эмоция")
            case Cosmetics.Types.contrail.rawValue:
                results.append("Воздушный cлед")
            case Cosmetics.Types.pickaxe.rawValue:
                results.append("Инструмент")
            case Cosmetics.Types.loadingscreen.rawValue:
                results.append("Экран загрузки")
            case Cosmetics.Types.all.rawValue:
                results.append("Все")
            default:
                results.append("Неизвестный тип")
            }
        }
                
        return results
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<types.count, id: \.self) { index in
                    Text(localizedTypes[index])
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(sortSelection.rawValue == types[index] ? Color("Dark") : .secondary)
                        .background(sortSelection.rawValue == types[index]  ? Color("Yellow") : Color("Light"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            sortSelection = Cosmetics.Types(rawValue: types[index]) ?? .all
                        }
                        .padding(.leading, index == 0 ? 16 : 0)
                        .padding(.trailing, index == types.count - 1 ? 16 : 0)
                }
            }
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
