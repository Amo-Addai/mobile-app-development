//
//  CircleGroupView.swift
//  restart-app
//
//  Created by Kwadwo Amo-Addai on 8/19/24.
//

import SwiftUI

struct CircleGroupView: View {
    
    // MARK: State Vars (
    
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State var AnimationDuration: Double
    
    @State // private @State var with assigned value; not required during instantiation
    private var isAnimating: Bool = false
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke( // circle-shape border
                    ShapeColor.opacity(ShapeOpacity),
                    lineWidth: 40
                )
                .frame( // containing-frame size/props
                    width: 260,
                    height: 260,
                    alignment: .center
                )
            
            // both circles have same white-opacity 0.2
            // but their intersecting areas' opacity combine to have a much lighter opacity ('about' 0.4)
            // 1 circle is not overlayed entirely on top of the other, because they both have %d opacities
            
            Circle()
                .stroke(
                    ShapeColor.opacity(ShapeOpacity),
                    lineWidth: 80
                )
                .frame(
                    width: 260,
                    height: 260,
                    alignment: .center
                )
            
        }
        .opacity(isAnimating ? 1 : 0)
        .blur( // blur elem when animating
            radius: isAnimating ? 0 : 10
        )
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(
            .easeIn(
                duration: AnimationDuration
            ),
            value: isAnimating
        )
        .onAppear(
            perform: {
                isAnimating = true
            }
        )

    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Color("ColorBlue")
                .ignoresSafeArea(
                    .all,
                    edges: .all
                )
            
            // render component with default @State vars
            CircleGroupView(
                ShapeColor: .white,
                ShapeOpacity: 0.2,
                AnimationDuration: 1
            )
            
        }
    }
}
