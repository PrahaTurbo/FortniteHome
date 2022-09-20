//
//  ContentView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var cosmeticViewModel = CosmeticsViewModel()
        
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
