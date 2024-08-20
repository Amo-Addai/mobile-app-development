//
//  OnboardingView.swift
//  restart-app
//
//  Created by Kwadwo Amo-Addai on 8/18/24.
//

import SwiftUI

struct OnboardingView: View {
    
    
    // MARK: Properties
    
    @AppStorage("onboarding") // getting app state property, already in storage (saved by ContentView)
    var isOnboardingViewActive: Bool = true // default-initialization is skipped since var already exists in app storage state (wouldn't be skipped if var didn't exist in storage)
    // TODO: find out if storage property is also/only updated if it already exists, by this 'true' assignment (eg. if 'false' would change its initial 'true' value from ContentView)
    
    @State
    private var buttonBaseWidth: Double =
        UIScreen.main.bounds.width - 80
    
    @State
    private var buttonOffset: CGFloat = 0
    
    @State
    private var buttonDiameter: Double = 80
    
    @State
    private var isAnimating: Bool = false
    // toggles on parent component render; used for all animations in this view
    
    @State
    private var imageOffset: CGSize = CGSize(width: 0, height: 0) // == .zero enum
    
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                
                // MARK: Header
                
                Spacer() // max free-space of container
                
                VStack(spacing: 0) {
                    
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text(
                        """
                        It's not how much we give but
                        how much love we put into giving.
                        """
                    )
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40) // -ve y-offset starts elem above top
                .animation( // animate on render (ease-in elem while it starts from above-top to its normal position)
                    // _ animation: Animation?
                    .easeIn( // TODO: Find out why 'easeOut' has a similar but faster effect (but doesn't actually 'disappear' the elem)
                        duration: 1
                    ),
                    value: isAnimating
                )
                
                // MARK: Center
                
                ZStack {
                    
                    CircleGroupView(
                        ShapeColor: Color.white,
                        ShapeOpacity: 0.2,
                        AnimationDuration: 1
                    )
                    
                    // animation replaced by component's better implementation (with @State var AnimationDuration: 1)
                    // so animaiton is also used in HomeView's utilization
                    
//                    .opacity(isAnimating ? 1 : 0)
//                    .animation(
//                        .easeIn(
//                            duration: 0.2
//                        ),
//                        value: isAnimating
//                    )
                    
                    // but now, adding another offset-animation, specific to this view
                    .offset(
                        x: imageOffset.width * -1.2,
                        y: 0
                    )
                    .animation(
                        .easeOut(
                            duration: 1
                        ),
                        value: imageOffset
                    )
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(
                            x: imageOffset.width * 1.2,
                            y: 0
                        )
                        .padding(20)
                        .animation(
                            .easeOut(
                                duration: 0.7
                            ),
                            value: isAnimating
                        )
                        // has to be exec'd before gesture & animation modifiers (explanation below)
                        .rotationEffect(
                            .degrees(
                                Double(
                                    imageOffset.width / 20
                                )
                            )
                        )
                        .gesture(
                            
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation // CGSize()
                                    }
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    // can also decrement imageOffset's width & height until .zero, withAnimation
                                }
                            
                        ) // can also modify Image's animation, based on change in imageOffset
                        .animation(
                            .easeOut(
                                duration: 1
                            ),
                            value: imageOffset
                        )
                        /*
                         
                         // TODO: both gesture & last animation modifiers exec'd before rotationEffect affect ux differently
                         
                         
                        */
                    
                }
                
                Spacer()
                
                
                // MARK: Footer
                
                ZStack {
                    
                    // Parts of custom button slider
                    
                    // background (static)
                    
                    Capsule()
                        .fill(
                            Color.white.opacity(0.2)
                        )
                    
                    Capsule()
                        .fill(
                            .white.opacity(0.2)
                        )
                        .padding(8)
                    
                    // CTA (static)
                    
                    Text("Get Started")
                        .font(
                            .system(
                                .title3,
                                design: .rounded
                            )
                        )
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20) // x-axis left-padding (-val for right-padding)
                    
                    // capsule (dynamic width)
                    
                    HStack {
                        
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(
                                width: buttonOffset + buttonDiameter
                            )
                        // will move horizontally, with next HStack's Circle components
                        // so its with should be the button's offset + diameter/width
                        
                        if !isAnimating
                            || buttonBaseWidth
                            > buttonOffset + buttonDiameter {
                            Spacer()
                        }
                        /*
                         when incrementing buttonBaseWidth meets (==) buttonOffset + buttonDiameter, Spacer's default width will auto-extend ..
                         parent ZStack's backgroud (static) Capsule (the outer-most containing capsule for the footer) ..
                         so only render Spacer() otherwise
                         */
                        
                    }
                    
                    // circle (draggable shape)
                    
                    HStack {
                        
                        ZStack {
                            
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(
                                    .black.opacity(0.15)
                                )
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(
                                    .system(
                                        size: 24,
                                        weight: .bold
                                    )
                                )
                            
                        }
                        .foregroundColor(.white)
                        .frame(
                            width: buttonDiameter,
                            height: buttonDiameter,
                            alignment: .center
                        )
                        .offset(x: buttonOffset)
                        
                        // replaced by Drag-Gesture
//                        .onTapGesture {
//                            isOnboardingViewActive = false // TODO: Change Navigation method
//                            // only re-renders Home() based on this app storage state var
//                        }
                        
                        .gesture(
                            
                            // _ gesture:
                            DragGesture()
                                .onChanged { gesture in
                                    
                                    // increment buttonOffset based on gesture's translation width (with a max-width at buttonBaseWidth - circular button's diameter (80 points))
                                    if gesture
                                        .translation
                                        .width > 0 {
                                        guard
                                            buttonOffset >= buttonBaseWidth - buttonDiameter
                                        else {
                                            buttonOffset = gesture
                                                .translation
                                                .width
                                            
// TODO:                                    Error - 'guard' body must not fall through, consider using a 'return' or 'throw' to exit the scope
                                            return // out of only this scope; not entire onChanged closure
                                        }
                                    }
                                    
                                }
                                .onEnded { _ in
                                    
                                    /* TODO: Option 1 - slide button without animation
                                    
                                    // snap button to right edge if offset > 1/2 of base width; else snap button back to left edge
                                    
                                    // TODO: ios doesn't handle snap-effect perfectly by default
                                    // snapping back to left-edge looks okay due to surrounding capsule's increasing width
                                    // snapping to the right-edge requires more transition-x animation to the right
                                    
                                    if buttonOffset
                                        > buttonBaseWidth / 2 {
                                        while
                                            buttonOffset < buttonBaseWidth - buttonDiameter
                                            {
                                            // TODO: implement animation better
                                            // TODO: can increment buttonOffset with an ms delay
                                            buttonOffset += 1
                                            // better slide-animation implemented below this multi-line comment
                                        }
                                        
                                        isOnboardingViewActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                    
                                    */
                                    
                                    // Option 2 - slide button with animation
                                    
                                    withAnimation(
                                        .easeOut(
                                            duration: 0.4
                                        )
                                    ) {
                                        if buttonOffset
                                            > buttonBaseWidth / 2 {
                                            while
                                                buttonOffset < (buttonBaseWidth - buttonDiameter) + 1
                                                {
                                                buttonOffset += 1
                                            }
                                            
                                            // delay navigation on a bg-thread for ms
                                            // for buttonOffset animation to complete
                                            
                                            DispatchQueue
                                                .main
                                                .asyncAfter(
                                                    deadline: .now() + 0.5,
                                                    execute: {
                                                        
                                                        withAnimation { // no _ animation: arg given; default animation given (fade-in on render | fade-out on de-render)
                                                        
                                                            isOnboardingViewActive = false
                                                        
                                                        }
                                                    }
                                                )
                                            
                                        } else {
                                            buttonOffset = 0
                                        }
                                    }
                                    
                                }
                            
                        )
                        
                        Spacer() // push ZStack to left-edge of HStack
                        
                    }
                    
                }
                .frame(
                    width: buttonBaseWidth,
                    height: 80,
                    alignment: .center
                )
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40) // +ve y-offset starts elem from below top by 40 points
                .padding()
                .animation(
                    .easeIn(
                        duration: 1
                    ),
                    value: isAnimating
                )
                
            }
        }
        .onAppear(
            perform: {
                isAnimating = true
            }
        )
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
