//
//  SplashScreen.swift
//  sample
//
//  Created by Kwadwo Amo-Addai on 8/18/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @AppStorage("onboarding") // saving app state property in storage
    var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack { // Z-axis / Centered Stack
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
