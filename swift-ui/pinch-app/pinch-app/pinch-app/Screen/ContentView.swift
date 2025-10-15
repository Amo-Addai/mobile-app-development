//
//  ContentView.swift
//  pinch-app
//
//  Created by Kwadwo Amo-Addai on 10/15/25.
//

import SwiftUI

struct ContentView: View {
    
//    MARK: Property
    
    @State private var isAnimating: Bool = false
    
//    MARK: Function
    
//    MARK: Content
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
        } //: Navigation
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
