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
                        ShopSection(items: viewModel.featuredSection, title: "featured-title")
                        
                        ShopSection(items: viewModel.specialFeaturedSection, title: "special-title")
                        
                        ShopSection(items: viewModel.dailySection, title: "daily-title")
                        
                        ShopSection(items: viewModel.specialDailySection, title: "special-daily-title")
                        
                        ShopSection(items: viewModel.voteWinnersSection, title: "vote-winners-title")
                        
                        ShopSection(items: viewModel.votesSection, title: "votes-title")
                        
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
                await viewModel.getItems()
            }
            .navigationTitle("shop-title")
            .onReceive(viewModel.timer) { input in
                Task {
                   await viewModel.countdown(input: input)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.isLoading {
                        Text(viewModel.timeRemaining)
                            .foregroundColor(.secondary)
                            .font(.subheadline.bold())
                    }
                }
            }
            
        }
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
