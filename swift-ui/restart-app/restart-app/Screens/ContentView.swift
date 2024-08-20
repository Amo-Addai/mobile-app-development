//
//  ContentView.swift
//  restart-app
//
//  Created by Kwadwo Amo-Addai on 8/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") // saving app state property in storage
    var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
        .preferredColorScheme(AppConfig.appearance) // Global ColorScheme for entire app (from Config/Constants.swift)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
