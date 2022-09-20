//
//  ItemsList.swift
//  FortniteHome
//
//  Created by Артем Ластович on 02.05.2022.
//

import SwiftUI
import NukeUI

struct ItemsList: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    let items: [Cosmetics.Item]
    var selectionIsOn = false
    
    var body: some View {
        if selectionIsOn {
            ForEach(items, id: \.id) { item in
                NavigationLink(tag: item.name, selection: $navigationHelper.selection) {
                    CosmeticDetailsView(item: item)
                } label: {
                    HStack {
                        if let url = item.images.icon {
                            LazyImage(source: url) { state in
                                if let image = state.image {
                                    image
                                        .resizingMode(.aspectFit)
                                } else if state.error != nil {
                                    Color.red
                                    
                                    K.SFSymbols.xmark
                                        .font(.largeTitle)
                                } else {
                                    K.Colors.secondaryColor
                                }
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .scaleEffect(0.8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type.displayValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(K.Colors.secondaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                .buttonStyle(ScaledButton())
            }
        } else {
            ForEach(items, id: \.id) { item in
                NavigationLink {
                    CosmeticDetailsView(item: item)
                } label: {
                    HStack {
                        if let url = item.images.icon {
                            LazyImage(source: url) { state in
                                if let image = state.image {
                                    image
                                        .resizingMode(.aspectFit)
                                } else if state.error != nil {
                                    Color.red
                                    
                                    K.SFSymbols.xmark
                                        .font(.largeTitle)
                                } else {
                                    K.Colors.secondaryColor
                                }
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .scaleEffect(0.8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type.displayValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(K.Colors.secondaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                .buttonStyle(ScaledButton())
            }
        }
    }
}

struct ItemsList_Previews: PreviewProvider {
    static var items: Cosmetics = Bundle.main.decode("cosmeticsExample.json")
    
    static var previews: some View {
        ItemsList(items: items.items)
    }
}
