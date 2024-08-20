//
//  HomeView.swift
//  restart-app
//
//  Created by Kwadwo Amo-Addai on 8/18/24.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding")
    var isOnboardingViewActive: Bool = false // default-initialization is skipped since var already still exists in app storage state
    // var would be assigned false by default, if it doesn't exist as a storage property
    
    @State
    private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: Header
            
            Spacer()
            
            ZStack {
                
                CircleGroupView(
                    ShapeColor: .gray,
                    ShapeOpacity: 0.1,
                    AnimationDuration: 1
                )
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 20 : -50)
                    .padding()
                    .animation(
                        .easeInOut(
                            duration: 1
                        )
                        .repeatForever(),
                        value: isAnimating
                    )
                
            }
            
            
            // MARK: Center
            
            Text(
                """
                The time that leads to mastery is
                dependent on the intensity of our focus.
                """
            )
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding()
            
            
            // MARK: Footer
            
            Spacer()
            
            Button(
                action: {
                    withAnimation {
                        
                        playSound(
                            fileName: "success",
                            fileType: "m4a"
                        )
                        
                        isOnboardingViewActive = true // updates "onboarding" app storage property
                        // updates property back to true, because this button navigates back to OnboardingView
                        // (parent ContentView re-renders sibling OnboardingView)
                        
                    }
                }
            ) { // Button's content horizontally aligned by default
                
                Image(
                    systemName:
                        "arrow.triangle.2.circlepath.circle.fill"
                )
                .imageScale(.large)
                
                Text("Restart")
                    .font(
                        .system(
                            .title3,
                            design: .rounded
                        )
                    )
                    .fontWeight(.bold)
                
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }
        .onAppear(
            perform: {
                DispatchQueue
                    .main
                    .asyncAfter(
                        deadline: .now() + 1,
                        execute: {
                            isAnimating = true
                        }
                    )
            }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
