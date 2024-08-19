//
//  CircleGroup.swift
//  sample
//
//  Created by Kwadwo Amo-Addai on 8/19/24.
//

import SwiftUI

// MARK: Reusable Component

struct CircleGroup: View {
    
    // MARK: View/Component State Vars
    
    @State var ShapeColor: Color
    @State
    var shapeOpacity: Double
    
    @State // private @State var with assigned value; not required during instantiation
    private var isAnimating: Bool = false
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke( // circle-shape border
                    ShapeColor.opacity(shapeOpacity),
                    lineWidth: 40
                )
                .frame( // containing-frame size/props
                    width: 260, // in-line comment only affects neighboring lines' labels syntax-highlighting (not code execution)
                    height: 260,
                    alignment: .center
                )
            
            // both circles have same white-opacity 0.2
            // but their intersecting areas' opacity combine to have a much lighter opacity ('about' 0.4)
            // 1 circle is not overlayed entirely on top of the other, because they both have %d opacities
            
            Circle()
                .stroke(
                    ShapeColor.opacity(shapeOpacity),
                    lineWidth: 80
                )
                .frame(
                    width: 260,
                    height: 260,
                    alignment: .center
                )
            
        }

    }
}

struct CircleGroup_Previews: PreviewProvider {
    static var previews: some View {
        ZStack { // can also update UI in PreviewProvider View
            
            Color("ColorBlue")
                .ignoresSafeArea(
                    .all,
                    edges: .all
                )
            
            // render component with default @State vars
            CircleGroup(
                ShapeColor: .white,
                shapeOpacity: 0.2
                // , isAnimating: true // TODO: Error when instantiating with a private @State var
            )
            
        }
    }
}
