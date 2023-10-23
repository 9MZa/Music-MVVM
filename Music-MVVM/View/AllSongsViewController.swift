//
//  AllSongsViewController.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import UIKit


class AllSongsViewController: UIViewController {
    var tableView: UITableView!
    var viewModel = SongViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.prepareSongs()
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        view.addSubview(tableView)
    }
}

extension AllSongsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        let song = viewModel.songs[indexPath.row]
        cell.titleLabel.text = song.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSong = viewModel.songs[indexPath.row]
        AudioPlayerService.shared.setCurrentSong(selectedSong)
    }
}
