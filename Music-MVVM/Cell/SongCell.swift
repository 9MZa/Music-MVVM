//
//  SongCell.swift
//  Music-MVVM
//
//  Created by Bandit Silachai on 23/10/23.
//

import UIKit

class SongCell: UITableViewCell {
    var titleLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 10, y: 10, width: contentView.frame.size.width - 20, height: 20)
        contentView.addSubview(titleLabel)
    }
}
