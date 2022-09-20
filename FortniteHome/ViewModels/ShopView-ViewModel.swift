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
        @Published var date = Date()
        @Published var currentDate = Date()
        @Published var isLoading = true
        
        private let url = "https://fortnite-api.com/v2/shop/br?language="
        private var language: String {
            return Locale.preferredLanguages.first?.dropLast(3) == "ru" ? "ru" : "en"
        }
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var timeRemaining: String {
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: date)
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru")
            formatter.setLocalizedDateFormatFromTemplate("HHmmss")
            
            let date = Calendar.current.date(from: components) ?? Date.now
            return formatter.string(from: date)
        }
        
        func countdown(input date: Date) async {
            currentDate = date
            
            if timeRemaining == "00:00:00" {
                await getItems()
            }
        }
        
        func getItems() async {
            do {
                let result: ShopCollection = try await NetworkService.shared.fetchData(url: url + language)
                featuredSection = result.featuredSection
                dailySection = result.dailySection
                specialFeaturedSection = result.specialFeaturedSection
                specialDailySection = result.specialDailySection
                votesSection = result.votesSection
                voteWinnersSection = result.voteWinnersSection
                date = result.date
                
                isLoading = false
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
