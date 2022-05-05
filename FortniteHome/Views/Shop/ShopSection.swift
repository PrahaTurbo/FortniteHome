//
//  ShopSectionView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 22.04.2022.
//

import SwiftUI
import NukeUI

struct ShopSection: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    let items: [Shop.ShopData.ShopSection.Entry]
    let title: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if !items.isEmpty {
                Section {
                    LazyVGrid(columns: columns) {
                        ForEach(items, id: \.offerId) { item in
                            if let url = item.newDisplayAsset?.materialInstances[0].images["Background"] {
                                NavigationLink(tag: item.offerId, selection: $navigationHelper.selection) {
                                    ShopItemDetailsView(entry: item)
                                } label: {
                                    ZStack(alignment: .bottomLeading) {
                                        LazyImage(source: url) { state in
                                            if let image = state.image {
                                                image
                                                    .resizingMode(.aspectFit)
                                                
                                            } else if state.error != nil {
                                                Color.red
                                                
                                                Image(systemName: "xmark")
                                                    .font(.largeTitle)
                                            } else {
                                                Color("Light")
                                                
                                            }
                                        }
                                        .aspectRatio(1, contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                        
                                        HStack {
                                            Text(String(item.finalPrice))
                                                .font(.title3.weight(.black))
                                            
                                            Image("vbucks")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25)
                                        }
                                        .padding(10)
                                        .shadow(radius: 5)
                                        
                                    }
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                }
                                .buttonStyle(ScaledButton())
                            }
                        }
                    }
                } header: {
                    Text(title)
                        .font(.title.bold())
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
            }
        }
        .padding(.bottom)
    }
}

struct ShopSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .preferredColorScheme(.dark)
    }
}
