//
//  CosmeticsView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import SwiftUI

struct CosmeticsView: View {
    @EnvironmentObject private var viewModel: CosmeticsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Dark").ignoresSafeArea()
                ScrollView {
                    LazyVStack {
                        SearchBar(searchText: $viewModel.searchText)
                            .padding(.horizontal)
                            .animation(nil, value: viewModel.searchText)
                        
                        CosmeticsTypeFilter(types: viewModel.sortingTypes, sortSelection: $viewModel.currentSortingType)
                            .padding(.bottom)
                        
                        ItemsList(items: viewModel.sortedItems, selectionIsOn: true)
                            .padding(.horizontal)
                        
                    }
                    .padding(.bottom, 40)
                    .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)
                    .animation(.spring(), value: viewModel.searchText)
                }
                .navigationTitle("items-title")
                
                if viewModel.isLoading {
                    Color("Dark")
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
            }
        }
    }
}

struct CosmeticsView_Previews: PreviewProvider {
    
    static var previews: some View {
        CosmeticsView()
            .environmentObject(CosmeticsViewModel())
            .preferredColorScheme(.dark)
    }
}
