//
//  StatsSuccessCard.swift
//  FortniteHome
//
//  Created by Артем Ластович on 01.05.2022.
//

import SwiftUI

struct StatsSuccessCard: View {
    @EnvironmentObject var viewModel: StatsView.ViewModel
    
    let stats: Stats
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Text(stats.data.account.name)
                    .font(.title.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                
                Button {
                    withAnimation(.spring()) {
                        viewModel.reset()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(Color("Yellow"))
                }
            }
            
            
            if let overall = stats.data.stats.all?.overall {
                HStack {
                    VStack {
                        Text(String(overall.kills))
                            .font(.title.weight(.black))
                        
                        Text("убийств")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack {
                        Text(String(overall.deaths))
                            .font(.title.weight(.black))
                        
                        Text("смертей")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100)
                    
                }
                
                Divider()
                
                HStack {
                    VStack {
                        Text(String(overall.wins))
                            .font(.title.weight(.black))
                        
                        Text("побед")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack {
                        Text(String(overall.matches))
                            .font(.title.weight(.black))
                        
                        Text("матчей")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100)
                    
                }
                
                Divider()
                
                HStack {
                    VStack {
                        Text(String(format: "%.1f", overall.kd))
                            .font(.title.weight(.black))
                        
                        Text("к/д")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack {
                        Text(String(overall.minutesPlayed))
                            .font(.title.weight(.black))
                        
                        Text("минут")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100)
                    
                }
            } else {
                StatsErrorCard(title: "Статистики пока нет :(", icon: "exclamationmark.triangle.fill", iconColor: Color("Yellow"))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("Light"))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .transition(.scale)
    }
}

struct StatsSuccessCard_Previews: PreviewProvider {
    static var stats: Stats = Bundle.main.decode("statsExample.json")
    
    static var previews: some View {
        StatsSuccessCard(stats: stats)
    }
}
