//
//  CustomTabBar.swift
//  FortniteHome
//
//  Created by Артем Ластович on 19.04.2022.
//

import SwiftUI

struct CustomTabBar: View {
    enum Tab: String, CaseIterable {
        case news, shop, cosmetics, stats
        
        var name: String {
            switch self {
            case .news:
                return K.SFSymbols.news
            case .shop:
                return K.SFSymbols.shop
            case .cosmetics:
                return K.SFSymbols.cosmetics
            case .stats:
                return K.SFSymbols.stats
            }
        }
    }
    
    @StateObject var shopNavigationHelper = NavigationHelper()
    @StateObject var cosmeticsNavigationHelper = NavigationHelper()

    @Namespace var namespace
    
    @State private var currentTab = Tab.news
    
    var body: some View {
        ZStack {
            TabView(selection: $currentTab) {
                NewsView()
                    .tag(Tab.news)
                
                
                ShopView()
                    .tag(Tab.shop)
                    .environmentObject(shopNavigationHelper)
                
                CosmeticsView()
                    .tag(Tab.cosmetics)
                    .environmentObject(cosmeticsNavigationHelper)
                
                StatsView()
                    .tag(Tab.stats)
            }
            .overlay(
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        TabButton(tab: tab)
                    }
                }
                .padding(.vertical)
                .padding(.bottom, getSaveArea().bottom == 0 ? 10 : (getSaveArea().bottom - 10))
                .background(K.Colors.secondaryColor),
                
                alignment: .bottom
            )
            .ignoresSafeArea(.all, edges: .bottom)
            .preferredColorScheme(.dark)
        }
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        Image(systemName: currentTab == tab ? "\(tab.name).fill" : tab.name)
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .frame(maxWidth: .infinity)
            .foregroundColor(currentTab == tab ? K.Colors.accentColor : .secondary)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab == tab {
                    if tab == .shop {
                        shopNavigationHelper.selection = nil
                    } else if tab == .cosmetics {
                        cosmeticsNavigationHelper.selection = nil
                    }
                }                
                currentTab = tab
            }
            .frame(height: 40)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
