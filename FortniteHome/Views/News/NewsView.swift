//
//  NewsView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 15.04.2022.
//

import SwiftUI

struct ScaledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct NewsView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Dark").ignoresSafeArea()
                
                ScrollView {
                        ScrollViewReader { proxy in
                            ForEach(viewModel.battleRoyaleNews.reversed(), id: \.self) { item in
                                NewsItemCard(item: item) { news in
                                    proxy.scrollTo(news.hashValue, anchor: UnitPoint(x: 0.5, y: 0.1))
                                }
                                .buttonStyle(ScaledButton())
                                .id(item.hashValue)
                                .padding(.horizontal)
                            }
                            .padding(.bottom, 40)
                            .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)
                    }
                }
            }
            .task {
                await viewModel.getNews()
            }
            .navigationTitle("news-title")
        }
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
