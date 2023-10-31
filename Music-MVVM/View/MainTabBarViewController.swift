//
//  MainTabBarViewController.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import UIKit
import Combine

class MainTabBarViewController: UITabBarController {
    var miniPlayerView: UIView!
    var miniPlayerTitleLabel: UILabel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiniPlayer()
        setupViewControllers()
        observeSongChange()
    }
    
    func setupMiniPlayer() {
        // Create the mini player view and add it above the tab bar.
        miniPlayerView = UIView(frame: CGRect(x: 0, y: tabBar.frame.origin.y - 120, width: view.frame.width, height: 60))
        miniPlayerView.backgroundColor = .lightGray
        
        miniPlayerTitleLabel = UILabel(frame: miniPlayerView.bounds)
        miniPlayerTitleLabel.textAlignment = .center
        
        miniPlayerView.addSubview(miniPlayerTitleLabel)
        
        // Add the mini player view above the tab bar.
        view.addSubview(miniPlayerView)
    }
    
    
    func setupViewControllers() {
        let allSongsVC = AllSongsViewController()
        allSongsVC.title = "All Songs"
        allSongsVC.tabBarItem = UITabBarItem(title: "All Songs", image: UIImage(systemName: "list.bullet"), tag: 0)
        
        let nowPlayingVC = NowPlayingViewController()
        nowPlayingVC.title = "Now Playing"
        nowPlayingVC.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "play"), tag: 1)
        
        viewControllers = [allSongsVC, nowPlayingVC]
    }
    
    func observeSongChange() {
        AudioPlayerService.shared.currentSongPublisher
            .sink(receiveValue: { [weak self] song in
                if let song = song {
                    self?.miniPlayerTitleLabel.text = "กำลังเล่น \(song.title)"
                } else {
                    self?.miniPlayerTitleLabel.text = "No Song Playing"
                }
            })
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
