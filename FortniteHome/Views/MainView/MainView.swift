//
//  ContentView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var cosmeticViewModel: CosmeticsViewModel
    
    init() {        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "fortnitebattlefest", size: 50) ?? .boldSystemFont(ofSize: 50)]
        
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "fortnitebattlefest", size: 20) ?? .boldSystemFont(ofSize: 20)]
        
        _cosmeticViewModel = StateObject(wrappedValue: CosmeticsViewModel())
    }
        
    var body: some View {
        CustomTabBar()
            .environmentObject(cosmeticViewModel)
            .navigationViewStyle(.stack)
            .task {
                await cosmeticViewModel.getCosmeticItems()
            }
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
