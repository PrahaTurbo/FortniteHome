//
//  CosmeticDetailsView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 24.04.2022.
//

import SwiftUI
import NukeUI

struct CosmeticDetailsView: View {
    let item: Cosmetics.Item
    @EnvironmentObject private var viewModel: CosmeticsViewModel

    var body: some View {
        ZStack {
            Color("Dark").ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading) {
                    TabView {
                        if let url = item.images.featured {
                            LazyImage(source: url) { state in
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
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            
                        } else if let url = item.images.icon {
                            LazyImage(source: url) { state in
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
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        
                        if let showcaseVideo = item.showcaseVideo {
                            VideoView(videoId: showcaseVideo)
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                        
                    }
                    .tabViewStyle(.page)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text(item.name)
                            .font(.title2.bold())
                        
                        Text(item.description)
                        
                        if let introduction = item.introduction {
                            Text("Первое появление: ")
                            + Text("Глава \(introduction.chapter), Сезон \(introduction.season).")
                                .bold()
                        }
                        
                        if let shopHistory = item.shopHistory {
                            Text("Последнее появление в магазине: \(shopHistory.last?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")")
                                .foregroundColor(.secondary)
                                .padding(.top)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color("Light"))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.vertical)
                    
                    
                    if let setText = item.set?.text {
                        Text(setText.dropLast())
                            .font(.title3.bold())
                        + Text(":")
                            .font(.title3.bold())
                    }
                    
                    ItemsList(items: itemsSet)
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var itemsSet: [Cosmetics.Item] {
        if let set = item.set {
            return viewModel.cosmeticItems.filter { $0.set?.backendValue == set.backendValue}
        }
        return []
    }
}

struct CosmeticDetailsView_Previews: PreviewProvider {
    static let collection: Cosmetics = Bundle.main.decode("cosmeticsItems.json")
    
    static var previews: some View {
        CosmeticDetailsView(item: collection.items[0])
            .environmentObject(CosmeticsViewModel())
            .preferredColorScheme(.dark)
    }
}
