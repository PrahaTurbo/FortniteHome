//
//  ShopView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import SwiftUI

struct ShopView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Dark").ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ShopSection(items: viewModel.featuredSection, title: "Рекомендуемое")
                        
                        ShopSection(items: viewModel.specialFeaturedSection, title: "Специальное")
                        
                        ShopSection(items: viewModel.dailySection, title: "Ежедневное")
                        
                        ShopSection(items: viewModel.specialDailySection, title: "Специальное ежедневное")
                        
                        ShopSection(items: viewModel.voteWinnersSection, title: "Победители голосования")
                        
                        ShopSection(items: viewModel.votesSection, title: "Голосование")
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, -20)
                    .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)
                }
                
                if viewModel.isLoading {
                    Color("Dark")
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
            }
            .task {
                viewModel.isLoading = false
                await viewModel.getItems()
            }
            .navigationTitle("Магазин")
            
        }
        .environment(\.locale, .init(identifier: "ru"))
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .preferredColorScheme(.dark)
    }
}
