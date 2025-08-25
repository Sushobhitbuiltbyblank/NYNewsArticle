//
//  Untitled.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI

struct NYTNavigationBar: View {
    var title: String
    var body: some View {
        ZStack {
            Color("navColor")
                .ignoresSafeArea(edges: .top)
                .frame(height: 60)
            
            HStack {
                Button(action: {
                    print("Menu tapped")
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 15) {
                    Button(action: {
                        print("Search tapped")
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        print("More options tapped")
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NYTNavigationBar(title: "NY Times Most Popular")
}

struct NYTNavigationBarModifier: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            NYTNavigationBar(title: title)
            content
            Spacer()
        }
    }
}

extension View {
    func nytNavBar(_ title: String) -> some View {
        self.modifier(NYTNavigationBarModifier(title: title))
    }
}
