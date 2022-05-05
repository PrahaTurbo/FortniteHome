//
//  StatsView-ViewModel.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import Foundation

extension StatsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var stats: Stats?
        @Published var showingStats = false
        @Published var attempts = 0
        
        @Published var name = "" {
            didSet {
                if !name.isEmpty {
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(name) {
                        UserDefaults.standard.set(encoded, forKey: "Name")
                    }
                }
            }
        }
        
        let url = "https://fortnite-api.com/v2/stats/br/v2?name="
        
        private let service = Service()
        
        func getStats() async {
            do {
                let result: Stats = try await service.fetchData(url: url + name)
                stats = result
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func reset() {
            showingStats = false
            stats = nil
        }
        
        init() {
            if let savedName = UserDefaults.standard.data(forKey: "Name") {
                if let decodedName = try? JSONDecoder().decode(String.self, from: savedName) {
                    name = decodedName
                    return
                }
            }
            name = ""
        }
    }
}
