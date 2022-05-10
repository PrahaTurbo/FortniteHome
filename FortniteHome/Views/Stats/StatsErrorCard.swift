//
//  StatsErrorCard.swift
//  FortniteHome
//
//  Created by Артем Ластович on 02.05.2022.
//

import SwiftUI

struct StatsErrorCard: View {
    @EnvironmentObject var viewModel: StatsView.ViewModel
    
    let title: String
    let icon: String
    let iconColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.title)
                .padding()
            
            Text(LocalizedStringKey(title))
            
            Button {
                withAnimation(.spring()) {
                    viewModel.reset()
                }
            } label: {
                Text("OK")
                    .frame(maxWidth: .infinity)
                    .font(.title2.bold())
                    .padding()
                    .foregroundColor(Color("Dark"))
                    .background(Color("Yellow"))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .buttonStyle(ScaledButton())
            .padding(.vertical)
        }
    }
}

struct StatsErrorCard_Previews: PreviewProvider {
    static var previews: some View {
        StatsErrorCard(title: "Статистики пока нет :(", icon: "exclamationmark.triangle.fill", iconColor: .yellow)
    }
}
