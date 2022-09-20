//
//  NewsItemView.swift
//  FortniteHome
//
//  Created by Артем Ластович on 20.04.2022.
//

import NukeUI
import SwiftUI

struct NewsItemCard: View {
    @Namespace var namespace
    
    var item: News.Modes.NewsData.Message
    var scrollTo: (News.Modes.NewsData.Message) -> Void
    
    @State private var showingDetails = false
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                showingDetails.toggle()
                if showingDetails {
                    scrollTo(item)
                }
            }
        } label: {
            ZStack {
                LazyImage(source: item.image) { state in
                    if let image = state.image {
                        VStack(alignment: .leading) {
                            ZStack(alignment: .bottomLeading) {
                                image
                                    .resizingMode(.aspectFill)
                                
                                if !showingDetails {
                                    Text(item.title)
                                        .font(.title2.bold())
                                        .shadow(radius: 5)
                                        .padding()
                                        .matchedGeometryEffect(id: "title", in: namespace)
                                        .transition(.offset())
                                }
                            }
                            .aspectRatio(16/8, contentMode: .fit)

                            if showingDetails {
                                Text(item.title)
                                    .font(.title2.bold())
                                    .shadow(radius: 5)
                                    .padding()
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                    .transition(.offset())
                                
                                Text(item.body)
                                    .shadow(radius: 10)
                                    .padding()
                                    .padding(.top, -20)
                                
                                Spacer(minLength: 20)
                            }
                        }
                        .background(
                            image
                                .resizingMode(.aspectFill)
                                .blur(radius: 100)
                        )
                    } else if state.error != nil {
                        Color.red
                            .aspectRatio(16/8, contentMode: .fill)
                        
                        K.SFSymbols.xmark
                            .font(.largeTitle)
                    } else {
                        K.Colors.secondaryColor
                            .aspectRatio(16/8, contentMode: .fill)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.vertical, 5)
        }
    }
}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
