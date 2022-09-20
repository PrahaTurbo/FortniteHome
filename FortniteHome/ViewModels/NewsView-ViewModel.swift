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
        
        private let url = "https://fortnite-api.com/v2/news?language="
                
        private var language: String {
            return Locale.preferredLanguages.first?.dropLast(3) == "ru" ? "ru" : "en"
        }
        
        func getNews() async {
            do {
                let result: NewsCollection = try await NetworkService.shared.fetchData(url: url + language)
                battleRoyaleNews = result.battleRoyale
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
