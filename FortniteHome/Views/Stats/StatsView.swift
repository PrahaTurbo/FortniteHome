//
//  StatsView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 18.04.2022.
//

import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel = ViewModel()
    @FocusState private var isFocusing: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                K.Colors.primaryColor
                    .ignoresSafeArea()
                
                VStack {
                    if !viewModel.showingStats {
                        VStack {
                            Text("stats-input-nickname-text")
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                TextField("nickname-placeholder", text: $viewModel.name)
                                    .focused($isFocusing)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        isFocusing = false
                                    }
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                                    .modifier(Shake(animatableData: CGFloat(viewModel.attempts)))
                                
                                if !viewModel.name.isEmpty {
                                    Button {
                                        viewModel.name = ""
                                    } label: {
                                        K.SFSymbols.xmarkCircle
                                    }
                                }
                            }
                            .padding()
                            .background(K.Colors.primaryColor)
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
                                Text("show-button-text")
                                    .frame(maxWidth: .infinity)
                                    .font(.title2.bold())
                                    .padding()
                                    .foregroundColor(K.Colors.primaryColor)
                                    .background(K.Colors.accentColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            }
                            .buttonStyle(ScaledButton())
                            .padding(.vertical)
                        }
                        .padding()
                        .background(K.Colors.secondaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .transition(.scale)
                    }
                    
                    if viewModel.showingStats {
                        if let stats = viewModel.stats {
                            StatsSuccessCard(stats: stats)
                        } else {
                            VStack {
                                StatsErrorCard(title: "no-such-player", icon: "xmark.circle.fill", iconColor: .red)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(K.Colors.secondaryColor)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .transition(.scale)
                        }
                    }
                    
                }
                .padding()
                .padding(.bottom, 30)
                .padding(.bottom, getSaveArea().bottom == 0 ? 20 : 0)
                .navigationTitle("profile-title")
                .ignoresSafeArea(.keyboard)
            }
        }
        .environmentObject(viewModel)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .preferredColorScheme(.dark)
    }
}
