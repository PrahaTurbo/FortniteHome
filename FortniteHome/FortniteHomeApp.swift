//
//  FortniteHomeApp.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import SwiftUI

@main
struct FortniteHomeApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "fortnitebattlefest", size: 50) ?? .boldSystemFont(ofSize: 50)]
        
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "fortnitebattlefest", size: 20) ?? .boldSystemFont(ofSize: 20)]
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
