//
//  View+Ext.swift
//  FortniteHome
//
//  Created by Артем Ластович on 20.09.2022.
//

import SwiftUI

extension View {
    func getSaveArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let saveArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return saveArea
    }
}
