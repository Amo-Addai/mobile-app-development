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
    // TODO: is storage property also/only updated if it already exists, by this 'true' assignment (eg. if 'false' would change its initial 'true' value from ContentView)
    
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
    
    @State
    private var isArrowIndicatorAnimating: Bool = false
    
    @State
    private var arrowIndicatorOpacity: Double = 1
    
    @State
    private var textTitle: String = "Share"
    
    let hapticFeedback = UINotificationFeedbackGenerator() // to trigger Haptic-Feedback notifications
    // Haptic-Feedback features can only be tested on a physical device (turn on 'System Haptics' in 'Settings -> Sounds & Haptics')

    
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                
                // MARK: Header
                
                Spacer() // max free-space of container
                
                VStack(spacing: 0) {
                    
                    Text("\(textTitle).")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                        .transition(.opacity) // only expected to transition elem by its opacity alone when textTitle changes
                        // using this transition-animation alone (by default) shifts TextView a bit on x-axis (right-left on disappear; left-to-right on appear) - because SwiftUI recognizes this elem as 1, with only 1 elem-identifier, despite all state changes
                    
                        .id(textTitle) // specifies specific identifier as the current textTitle (:String) for each instance-state of this elem, so SwiftUI recognizes all states with different textTitle (:String) values with different unique IDs
                        // this enables expected transition-animation based on opacity alone, with no default x-axis transition-shifting
                        
                        // TODO: perhaps because all elem states (with different IDs) re-render with .opacity transition being static
                        // & without id(..), & SwiftUI using only 1 identifier for the elem despite state (textTitle) changes triggering tansition.opacity, a default x-axis transition shift is caused because the elem has already been rendered once & doesn't need to be re-rendered (because it still has the same .id-entifier
                    
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
                    .easeIn( // TODO: why 'easeOut' has a similar but faster effect (but doesn't actually 'disappear' the elem)
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
                        x: imageOffset.width * -1, // opposite-direction from Image, for parallax effect
                        y: 0
                    )
                    .blur(
                        radius: abs(imageOffset.width / 35)
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
                                        
                                        withAnimation(
                                            .linear(
                                                duration: 0.25
                                            )
                                        ) {
                                            textTitle = "Give"
                                            arrowIndicatorOpacity = 0 // hide arrowIndicator Image on-end, with linear animation
                                        }
                                    }
                                    
//                                    isArrowIndicatorAnimating = true // can be used to display arrowIndicator Image on-drag
                                    
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    // can also decrement imageOffset's width & height until .zero, withAnimation
                                    
                                    withAnimation(
                                        .linear(
                                            duration: 0.25
                                        )
                                    ) {
                                        textTitle = "Share"
                                        arrowIndicatorOpacity = 1 // re-display arrowIndicator Image on-end, with linear animation
                                    }
                                    
                                }
                            
                        ) // can also modify Image's animation, based on change in imageOffset
                        .animation(
                            .easeOut(
                                duration: 1
                            ),
                            value: imageOffset
                        )
                    
                        /*
                         
                         * // TODO: exactly why both gesture & last animation modifiers exec'd before rotationEffect affect ux differently
                         
                         Drag-gesture before rotation ends gesture immediately
                         animation before rotation distorts rotation a bit on-gesture-Ended
                         
                        */
                    
                }
                .overlay(
                    Image(
                        systemName:
                            "arrow.left.and.right.circle"
                    )
                    .font(
                        .system(
                            size: 44,
                            weight: .ultraLight
                        )
                    )
                    .foregroundColor(.white)
                    .offset(y: 20)
                    
                    .opacity( // replaces 2 opacities at the bottom (combines both isAnimating & arrowIndicatorOpacity usage)
                        isAnimating
                        ? arrowIndicatorOpacity // 1 by default; 0 on Drag Changed
                        : 0
                    ) // has to be exec'd before animation, for the easeIn effect when isAnimating == true (on containing VStack.onAppear)
                    .animation(
                        .easeInOut(
                            duration: 1
                        )
                        .delay(1), // only when elem is being rendered for the 1st time; doesn't delay re-appearing when arrowIndicatorOpacity = back to 1 (on "character-1" Image DragGesture Ended)
                        value: isAnimating
//                        value: isArrowIndicatorAnimating
                    )
                    
//                    .opacity(isArrowIndicatorAnimating ? 1 : 0), // TODO: can replace both opacity modifiers below (or only the 1st opacity modifier before animation) for this elem, with .animation value: also isArrowIndicatorAnimating so this elem appears on "character-1" Image DragGesture Changed (when isArrowIndicatorAnimating is toggled on)
                    
//                    .opacity(isAnimating ? 1 : 0)
//                    .opacity(arrowIndicatorOpacity), // this elem disappears when arrowIndicatorOpacity is toggled off (on "character-1" Image DragGesture Changed) & reappears on DragGesture Ended
                    
                    , alignment: .bottom
                )
                
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
                                                        
                                                            hapticFeedback
                                                                .notificationOccurred(
                                                                    .success
                                                                )
                                                            
                                                            playSound(
                                                                fileName: "chimeup",
                                                                fileType: "mp3"
                                                            ) // imported from Utilities/AudioPlayer/
                                                            
                                                            isOnboardingViewActive = false // parent ContentView renders sibling HomeView
                                                        
                                                        }
                                                    }
                                                )
                                            
                                        } else {
                                            buttonOffset = 0
                                            
                                            hapticFeedback
                                                .notificationOccurred(
                                                    .warning
                                                )
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
        
//        .preferredColorScheme(AppConfig.appearance) // sets light/dark mode for this view onAppear
        // TODO: but will also affect other screens navigating to this screen just before their navigation animations complete
        
        // Global ColorScheme for entire app has been set in main 'ContentView.swift' instead
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
