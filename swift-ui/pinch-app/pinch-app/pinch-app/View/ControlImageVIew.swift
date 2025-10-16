//
//  ControlImageVIew.swift
//  pinch-app
//
//  Created by Kwadwo Amo-Addai on 10/16/25.
//

import SwiftUI

struct ControlImageVIew: View {
    
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview {
    ControlImageVIew(icon: "minus.magnifyingglass")
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
