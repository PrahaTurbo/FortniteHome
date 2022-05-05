//
//  CustomTabBar.swift
//  FortniteHome
//
//  Created by Артем Ластович on 19.04.2022.
//

import SwiftUI

struct CustomTabBar: View {
    enum Tab: String, CaseIterable {
        case news = "newspaper"
        case shop = "cart"
        case cosmetics = "tshirt"
        case stats = "person"
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
                    .background(
                        Color("Light")
                    )
                
                ,alignment: .bottom
                
            )
            .ignoresSafeArea(.all, edges: .bottom)
            .preferredColorScheme(.dark)
        }
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        Image(systemName: currentTab == tab ? "\(tab.rawValue).fill" : tab.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .frame(maxWidth: .infinity)
            .foregroundColor(currentTab == tab ? Color("Yellow") : .secondary)
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
            .environmentObject(CosmeticsViewModel())
    }
}

extension View {
    func getSaveArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let saveArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return saveArea
    }
}
