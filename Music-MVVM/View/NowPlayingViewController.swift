//
//  NowPlayingViewController.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import UIKit
import Combine

class NowPlayingViewController: UIViewController {
    var titleLabel = UILabel()
    private var cancellables: Set<AnyCancellable> = []
    
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
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func observeSongChange() {
           AudioPlayerService.shared.currentSongPublisher
               .sink(receiveValue: { [weak self] song in
                   if let song = song {
                       self?.titleLabel.text = "กำลังเล่น \(song.title)"
                   } else {
                       self?.titleLabel.text = "No Song Playing"
                   }
               })
               .store(in: &cancellables)
       }

       deinit {
           cancellables.forEach { $0.cancel() }
       }
    
}
