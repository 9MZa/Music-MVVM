//
//  SongViewModel.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import Foundation
import AVFoundation

class SongViewModel {
    var songs: [Song] = []
    
    func prepareSongs() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            let mp3Files = items.filter { $0.hasSuffix(".mp3") }
            
            for item in mp3Files {
                let fileName = fileNameWithoutExtension(fromPath: item)
                if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
                    songs.append(Song(title: fileName, audioURL: url))
                }
            }
        } catch {
            print("Failed to read directory")
        }
    }
    
    func fileNameWithoutExtension(fromPath path: String) -> String {
        let fileName = URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent
        return fileName
    }
}
