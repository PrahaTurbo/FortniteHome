//
//  SearchBar.swift
//  FortniteHome
//
//  Created by Артем Ластович on 25.04.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var searchIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(K.Colors.secondaryColor)
                    
                    HStack {
                        K.SFSymbols.magnifyingGlass
                        
                        TextField("search-placeholder", text: $searchText)
                            .focused($searchIsFocused)
                            .submitLabel(.done)
                            .disableAutocorrection(true)
                        
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                K.SFSymbols.xmarkCircle
                            }
                            .padding(.trailing, 13)
                        }
                    }
                    .padding(.leading, 13)
                    .foregroundColor(.white)
                }
                .cornerRadius(13)                
            }
            .frame(height: 40)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        SearchBar(searchText: $text)
    }
}
