//
//  SongChangeNotificationHelper.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 24/10/23.
//

import Foundation

class NotificationHandler {
    static let shared = NotificationHandler()
    
    private init() { }
    
    func observeSongChangeNotification(withCallback callback: @escaping (Song?) -> Void) {
        NotificationCenter.default.addObserver(forName: Notification.Name("SongDidChangeNotification"), object: nil, queue: nil) { notification in
            if let now = AudioPlayerService.shared.currentSong() {
                callback(now)
            } else {
                callback(nil)
            }
        }
    }
    
    func removeSongChangeObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("SongDidChangeNotification"), object: nil)
    }
}
