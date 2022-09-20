//
//  ShopSectionView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 22.04.2022.
//

import SwiftUI
import NukeUI

struct ShopSection: View {
    
    let items: [Shop.ShopData.ShopSection.Entry]
    let title: LocalizedStringKey
    
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
                            ShopItemCard(item: item)
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
            .environmentObject(NavigationHelper())
    }
}
