//
//  StatsView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel: ViewModel
    @FocusState private var isFocusing: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Dark")
                    .ignoresSafeArea()
                
                VStack {
                    if !viewModel.showingStats {
                        VStack(alignment: .leading) {
                            Text("Введи свой никнейм в Fortnite, чтобы увидеть свою статистику:")
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                TextField("Никнейм", text: $viewModel.name)
                                    .focused($isFocusing)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        isFocusing = false
                                    }
                                    .modifier(Shake(animatableData: CGFloat(viewModel.attempts)))
                                
                                if !viewModel.name.isEmpty {
                                    Button {
                                        viewModel.name = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                        
                                    }
                                }
                            }
                            .padding()
                            .background(Color("Dark"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            
                            Button {
                                guard viewModel.name != "" else {
                                    withAnimation {
                                        viewModel.attempts += 1
                                    }
                                    return
                                }
                                
                                Task {
                                    await viewModel.getStats()
                                    withAnimation(.spring()) {
                                        viewModel.showingStats = true
                                    }
                                }
                            } label: {
                                Text("Показать")
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
                        .padding()
                        .background(Color("Light"))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .transition(.scale)
                    }
                    
                    if viewModel.showingStats {
                        if let stats = viewModel.stats {
                            StatsSuccessCard(stats: stats)
                        } else {
                            VStack {
                                StatsErrorCard(title: "Такого игрока нет", icon: "xmark.circle.fill", iconColor: .red)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Light"))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .transition(.scale)
                        }
                    }
                    
                }
                .padding()
                .padding(.bottom, 30)
                .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)
                .navigationTitle("Профиль")
                .ignoresSafeArea(.keyboard)
            }
        }
        .environmentObject(viewModel)
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .preferredColorScheme(.dark)
    }
}
