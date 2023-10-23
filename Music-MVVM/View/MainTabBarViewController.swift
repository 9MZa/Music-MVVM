//
//  MainTabBarViewController.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    var miniPlayerView: UIView!
    var miniPlayerTitleLabel: UILabel!
    let notificationHandler = NotificationHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiniPlayer()
        setupViewControllers()
        observeSongChange()
        
    }
    
    func setupMiniPlayer() {
        // Create the mini player view and add it above the tab bar.
        miniPlayerView = UIView(frame: CGRect(x: 0, y: tabBar.frame.origin.y - 60, width: view.frame.width, height: 60))
        miniPlayerView.backgroundColor = .lightGray
        
        miniPlayerTitleLabel = UILabel(frame: miniPlayerView.bounds)
        miniPlayerTitleLabel.textAlignment = .center
        
        if let now = AudioPlayerService.shared.currentSong() {
            miniPlayerTitleLabel.text = now.title
        } else {
            miniPlayerTitleLabel.text = "No Song Playing"
        }
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
        notificationHandler.observeSongChangeNotification { [weak self] song in
            if let song = song {
                self?.miniPlayerTitleLabel.text = song.title
            } else {
                self?.miniPlayerTitleLabel.text = "No Song Playing"
            }
        }
    }
    
    deinit {
        notificationHandler.removeSongChangeObserver()
    }
}
