//
//  ShopItemCard.swift
//  FortniteHome
//
//  Created by Артем Ластович on 20.09.2022.
//

import SwiftUI
import NukeUI

struct ShopItemCard: View {
    
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    let item: Shop.ShopData.ShopSection.Entry
    
    var body: some View {
        if let imageUrl = item.newDisplayAsset?.materialInstances[0].images["Background"] {
            NavigationLink(tag: item.offerId, selection: $navigationHelper.selection) {
                ShopItemDetailsView(entry: item)
            } label: {
                ZStack(alignment: .bottomLeading) {
                    LazyImage(source: imageUrl) { state in
                        if let image = state.image {
                            ZStack(alignment: .topLeading) {
                                image
                                    .resizingMode(.aspectFit)
                                
                                if let bannerText = item.banner?.value {
                                    if bannerText == "New!" || bannerText == "Новинка!" {
                                        Text(bannerText)
                                            .font(.subheadline.bold())
                                            .padding(5)
                                            .background(K.Colors.accentColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding(10)
                                            .foregroundColor(K.Colors.primaryColor)
                                    }
                                }
                            }
                        } else if state.error != nil {
                            Color.red
                            
                            K.SFSymbols.xmark
                                .font(.largeTitle)
                        } else {
                            K.Colors.secondaryColor
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

struct ShopItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationHelper())
    }
}
