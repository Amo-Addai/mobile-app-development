//
//  ContentView.swift
//  sample
//
//  Created by Kwadwo Amo-Addai on 8/17/24.
//

import SwiftUI


// Extension of Image type, for custom modifier-combos & other methods
extension Image { // best to be above main ContentView struct
    
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
    
}

struct ContentView: View {
    
    private let imageURL: String = "https://picsum.photos/200"
    
    var body: some View {
        
        
        // MARK: Init
        
        ZStack( // Z-axis Stack
            alignment: Alignment(
                horizontal: HorizontalAlignment(AlignmentID.Type),
                vertical: VerticalAlignment(AlignmentID.Type)
            )
        ) {
            // content-closure (for content: arg), with alignment: constructor arg
        }
        
        ZStack { // content-closure (with not constructor arg required - in this override)
            // children eg. SplashScreen()
        }
        
                                    
        // MARK: Basic
        
        AsyncImage(url: URL(string: self.imageURL))
        
        
        // MARK: Scale
        
        // scale: CGFloat: 1.0 - default scale - designed for non-retina screens ( < 1 - larger | > 2 - smaller)
        AsyncImage(url: URL(string: imageURL), scale: 3.0)
        
        
        // MARK: Placeholder
        
        /* // TODO: args error - content: (Image) -> View | placeholder: () -> View - provide a function / closure with UI rendering a View
        AsyncImage(
            url: URL(string: imageURL),
            content: Image(systemName: "photo.square.fill"),
            placeholder: Image(systemName: "photo.circle.fill")
        )
        */
        
        AsyncImage(
            url: URL(string: imageURL),
            content: { (image) in image }, // both closures return View
            placeholder: { () in Image(systemName: "photo.circle.fill") }
        )
        
        AsyncImage(
            url: URL(string: imageURL),
            content: { image in image }, // _ only nullifies a var (can't replace '0 () args')
            placeholder: { () in Image(systemName: "photo.circle.fill") }
        )
        
        AsyncImage(
            url: URL(string: imageURL),
            content: { (image: Image) in
                image
            }, placeholder: { // closure with no args can do away with the arg-in syntax
                Image(systemName: "photo.circle.fill")
            }
        )
        
        AsyncImage(
            url: URL(string: imageURL)
        ) { image in // last func-type params' 1st arg - content: (Image) -> .. value can be escaped & passed in as an 'external' closure
            image
        } placeholder: { // but all remaining func-type params' 'external' closures have to be labled
            Image(systemName: "photo.circle.fill")
        }
        
        /* // TODO: wrong multi-closure args - placeholder: has to be labelled
        AsyncImage(
            url: URL(string: imageURL)
        ) { image in
            image
        } {
            Image(systemName: "photo.circle.fill")
        }
        */
        
        AsyncImage(
            url: URL(string: imageURL)
        ) { image in
            image
                .resizable() // object .props (SwiftUI .modifiers)
                .scaledToFit() // in this case, cannot apply these modifiers directly to final AsyncImage object; have to be applied to this specific Image object
        } placeholder: {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .scaledToFit()
        }
        .padding(40) // SwiftUI .modifiers / style-props (only for .props of SwiftUI objects / content (object-returned) closures)
        
        AsyncImage(
            url: URL(string: imageURL)
        ) { image in
            image.imageModifier() // extension of Image with custom modifiers
        } placeholder: {
            Image(systemName: "photo.circle.fill")
                .iconModifier()
        }
        .padding(40)
        
        
        // MARK: Phase
        
        AsyncImage(
            url: URL(string: imageURL)
        ) { phase in // content: AsyncImagePhase value
            
            // success phase - image is successfully loaded
            // failure phase - image failed to fload with an error
            // empty phase - no image is loaded
            
            if let image = phase.image { // success
                image.imageModifier()
            } else if phase.error != nil { // failure
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            } else { // empty
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            }
            
        }
        .padding(40)
        
        AsyncImage(
            url: URL(string: imageURL)
        ) { phase in
            switch phase { // enum AsyncImagePhase
            case .success(let image): // (Image) - switch / enum case with let-var validation
                image.imageModifier()
            case .failure(_): // (Error) - nullified case with let-var validation
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            case .empty: // case with no let-var validation
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            @unknown default:
                ProgressView() // default component
            }
        }
        .padding(40)
        
        
        // MARK: Animations
        
        AsyncImage(
            url: URL(string: imageURL),
            transaction: Transaction( // animation transaction
                animation: // spring transition animation
                    // enum-case - as a method
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.6,
                        blendDuration: 0.25
                    )
            )
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
                    .transition(
                        // Move transition (another enum-case - as a method)
                        .move(
                            edge: .bottom // move from bottom to top (regular enum)
                        )
                    )
            case .failure(_):
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            @unknown default: ProgressView()
            }
        }
        .padding(40)
        
        AsyncImage(
            url: URL(string: imageURL),
            transaction: Transaction(
                animation:
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.6,
                        blendDuration: 0.25
                    )
            )
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
                    // TODO: test out all extra animations
                    // .transition(.slide) // slide transition (from left to right - default)
                    .transition(.scale) // scaling effect !== AsyncImage(scale: CGFloat - based on image size)
            case .failure(_):
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
