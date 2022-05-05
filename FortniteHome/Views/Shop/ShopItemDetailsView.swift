//
//  ShopItemDetailsView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 23.04.2022.
//

import SwiftUI
import NukeUI

struct ShopItemDetailsView: View {
    let entry: Shop.ShopData.ShopSection.Entry
    
    var body: some View {
        ZStack {
            Color("Dark").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    TabView {
                        if let items = entry.newDisplayAsset?.materialInstances {
                            ForEach(items, id: \.id) { item in
                                LazyImage(source: item.images["Background"]) { state in
                                    if let image = state.image {
                                        image
                                            .resizingMode(.aspectFit)
                                    } else if state.error != nil {
                                        Color.red
                                            .aspectRatio(1, contentMode: .fill)
                                        
                                        Image(systemName: "xmark")
                                            .font(.largeTitle)
                                    } else {
                                        Color("Light")
                                            .aspectRatio(1, contentMode: .fill)
                                        
                                        ProgressView()
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                    
                    Text(entry.bundle == nil ? entry.items[0].name : entry.bundle?.name ?? "Unknown name")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                    Text(String(entry.finalPrice))
                        .font(.title.weight(.black))
                        
                        Image("vbucks")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    
                    Text("В состав входят:")
                        .font(.title2.bold())
                    
                    ItemsList(items: entry.items)                    
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ShopItemDetailsView_Previews: PreviewProvider {
    static let items: ShopCollection = Bundle.main.decode("shopExample.json")
    
    static var previews: some View {
        NavigationView{
            ShopItemDetailsView(entry: items.featuredSection[0])
            .preferredColorScheme(.dark)
        }
    }
}
