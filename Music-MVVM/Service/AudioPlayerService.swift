//
//  AudioPlayerService.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import Foundation
import AVFoundation

class AudioPlayerService {
    static let shared = AudioPlayerService()
    
    private var audioPlayer: AVAudioPlayer?
    private var current: Song?
    
    func play() {
        audioPlayer?.play()
    }
    
    func setCurrentSong(_ song: Song) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: song.audioURL)
            audioPlayer?.play()
            current = song
            NotificationCenter.default.post(name: Notification.Name("SongDidChangeNotification"), object: nil)
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    
    func pause() {
        audioPlayer?.pause()
        
    }
    
    func stop() {
        audioPlayer?.stop()
    }
    
    func currentSong() -> Song? {
        return current
    }
    
    
    func isPlaying() -> Bool {
        return false
    }
    
}
