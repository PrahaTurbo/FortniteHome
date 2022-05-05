//
//  NewsView-ViewModel.swift
//  FortniteHome
//
//  Created by Артем Ластович on 15.04.2022.
//

import Foundation

extension NewsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var battleRoyaleNews = [News.Modes.NewsData.Message]()
        
        let url = "https://fortnite-api.com/v2/news?language=ru"
        
        private let service = Service()
        
        func getNews() async {
            do {
                let result: NewsCollection = try await service.fetchData(url: url)
                battleRoyaleNews = result.battleRoyale
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
