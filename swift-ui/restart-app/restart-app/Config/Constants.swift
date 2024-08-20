//
//  Constants.swift
//  restart-app
//
//  Created by Kwadwo Amo-Addai on 8/20/24.
//

import Foundation
import SwiftUI


private enum AppearanceModes { // TODO: extends ColorScheme
    case light
    case dark
}


struct AppConfig { // or class
    
    public static var appearance: ColorScheme = .light // TODO: set this dynamically
    // public static var appearance: AppearanceModes = .dark
    
}

