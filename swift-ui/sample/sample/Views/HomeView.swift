//
//  HomeView.swift
//  sample
//
//  Created by Kwadwo Amo-Addai on 8/18/24.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    // default-initialization is skipped since var already still exists in app storage state
    // var would be assigned false by default, if it doesn't exist as a storage property
    
    var body: some View {
        VStack() { // Vertical Stack - spacing: 20 omitted on purpose (for Spacer()s)
            
            HStack { // Horizontal Stack
                
                Text("Home")
                    .font(.largeTitle)
                
                Text("Home")
                    .font(.largeTitle)
                
            }
            
            // Spacer() // Takes max available space in container - pushes siblings to left/right edges, because of horizontal stack (similar: css - flex - justify-content: space-between)
            
            Button(
                action: {
                    isOnboardingViewActive = true // updates "onboarding" app storage property
                    // changes property back to true, because this button navigates back to OnboardingView
                }
            ) {
                Text("Restart")
            }
            
            Spacer() // with 1st spacer commented, will push both left-siblings to the far left of the HStack, leaving all remaining free space
            
            // MARK: Spacers aid spacing with ui-elements in containers, similar to how Swift-Cocoa's constraints aid containers' & children's positionings
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
