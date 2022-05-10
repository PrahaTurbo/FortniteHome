//
//  ShopView-ViewModel.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import Foundation

extension ShopView {
    @MainActor class ViewModel: ObservableObject {
        @Published var featuredSection = [Shop.ShopData.ShopSection.Entry]()
        @Published var dailySection = [Shop.ShopData.ShopSection.Entry]()
        @Published var specialFeaturedSection = [Shop.ShopData.ShopSection.Entry]()
        @Published var specialDailySection = [Shop.ShopData.ShopSection.Entry]()
        @Published var votesSection = [Shop.ShopData.ShopSection.Entry]()
        @Published var voteWinnersSection = [Shop.ShopData.ShopSection.Entry]()
        
        @Published var isLoading = true
        
        let url = "https://fortnite-api.com/v2/shop/br?language="
        
        var localLanguage = Locale.preferredLanguages.first?.dropLast(3)
        
        var wrappedLanguage: String {
            if localLanguage == "ru" {
                return String(localLanguage ?? "ru")
            } else {
                return "en"
            }
        }
        
        private let service = Service()
        
        func getItems() async {
            do {
                let result: ShopCollection = try await service.fetchData(url: url + wrappedLanguage)
                featuredSection = result.featuredSection
                dailySection = result.dailySection
                specialFeaturedSection = result.specialFeaturedSection
                specialDailySection = result.specialDailySection
                votesSection = result.votesSection
                voteWinnersSection = result.voteWinnersSection
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
