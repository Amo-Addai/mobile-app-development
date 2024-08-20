//
//  AudioPlayer.swift
//  restart-app
//
//  Created by Kwadwo Amo-Addai on 8/20/24.
//

import Foundation
import AVFoundation // working with media

var audioPlayer: AVAudioPlayer?

func playSound(
    fileName: String,
    fileType: String
) {
    
    print("playing sound file \(fileName).\(fileType)")
    
    if let filePath = // TODO: Get full paths from X-Code Assets too
        Bundle // From Foundation library
            .main
            .path( // auto-gets sound files from custom-directory /AssetFiles/
                forResource: fileName,
                ofType: fileType
            ) {
        do {
            audioPlayer =
                try AVAudioPlayer(
                    contentsOf: URL(
                        fileURLWithPath: filePath
                    )
                )
            audioPlayer?.play()
        } catch {
            print("Couldn't play the sound file \(fileName).\(fileType)")
        }
   }
}
