//
//  NowPlayingViewController.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import UIKit

class NowPlayingViewController: UIViewController {
    var titleLabel = UILabel()
    let notificationHandler = NotificationHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        observeSongChange()
    }
    
    func setupUI() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        if let now = AudioPlayerService.shared.currentSong() {
            titleLabel.text = now.title
        } else {
            titleLabel.text = "No Song Playing"
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func observeSongChange() {
        notificationHandler.observeSongChangeNotification { [weak self] song in
            if let song = song {
                self?.titleLabel.text = song.title
            } else {
                self?.titleLabel.text = "No Song Playing"
            }
        }
    }
    
    deinit {
        notificationHandler.removeSongChangeObserver()
    }
    
}
