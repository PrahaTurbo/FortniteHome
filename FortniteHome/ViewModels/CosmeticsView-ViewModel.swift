//
//  CosmeticsView-ViewModel.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import Foundation
@MainActor final class CosmeticsViewModel: ObservableObject {
    @Published var cosmeticItems = [Cosmetics.Item]()
    @Published var sortingTypes = [Cosmetics.Types.RawValue]()
    @Published var searchText = ""
    @Published var currentSortingType: Cosmetics.Types = .all
    @Published var isLoading = false
    
    let url = "https://fortnite-api.com/v2/cosmetics/br?language="
    
    var localLanguage = Locale.preferredLanguages.first?.dropLast(3)
    
    var wrappedLanguage: String {
        if localLanguage == "ru" {
            return String(localLanguage ?? "ru")
        } else {
            return "en"
        }
    }
    
    private let service = Service()
    
    var filteredItems: [Cosmetics.Item] {
        if searchText.isEmpty {
            return cosmeticItems
        } else {
            return cosmeticItems.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var sortedItems: [Cosmetics.Item] {
        switch currentSortingType {
        case .all:
            return filteredItems
        case .wrap:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.wrap.rawValue }
        case .backpack:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.backpack.rawValue }
        case .spray:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.spray.rawValue }
        case .music:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.music.rawValue }
        case .outfit:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.outfit.rawValue }
        case .contrail:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.contrail.rawValue }
        case .emote:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.emote.rawValue }
        case .pickaxe:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.pickaxe.rawValue }
        case .loadingscreen:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.loadingscreen.rawValue }
        case .glider:
            return filteredItems.filter { $0.type.value == Cosmetics.Types.glider.rawValue }
        }
    }
    
    func getCosmeticItems() async {
        do {
            isLoading = true
            
            let result: Cosmetics = try await service.fetchData(url: url + wrappedLanguage)
            cosmeticItems = result.items
            let types = result.items.map { $0.type.value }
            var uniqueTypes = Set(types).sorted()
            uniqueTypes.insert("all", at: 0)
            sortingTypes = uniqueTypes
            
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
}
