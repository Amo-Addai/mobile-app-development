//
//  OnboardingView.swift
//  sample
//
//  Created by Kwadwo Amo-Addai on 8/18/24.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: Properties
    
    @AppStorage("onboarding") // getting app state property, already in storage (saved by ContentView)
    var isOnboardingViewActive: Bool = true // default-initialization is skipped since var already exists in app storage state (wouldn't be skipped if var didn't exist in storage)
    // TODO: if storage property is also/only updated if it already exists, by this 'true' assignment (eg. if 'false' would change its initial 'true' value from ContentView)
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: 20) { // Vertical Stack with spacing-gap: 20
            
            Text("Onboarding")
                .font(.largeTitle)
            
            // re-using component (no need to import any external view-file / asset)
            CircleGroup(
                ShapeColor: Color.white,
                shapeOpacity: 0.2
            )
            
            Button(
                action: { // not a content-closure (no content returned); 'action' closure / lambda func
                    isOnboardingViewActive = false // updates "onboarding" app storage property
                    // TODO: if this re-assignment actually also updates the app storage property
                }
            ) {
                Text("Start")
            }
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
