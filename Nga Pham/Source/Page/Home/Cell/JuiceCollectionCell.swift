//
//  JuiceCollectionCell.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class JuiceCollectionCell: UICollectionViewCell {

    @IBOutlet weak var juiceImageView: UIImageView!
    @IBOutlet weak var juiceDescriptionLabel: UILabel!

    var viewModel: JuiceCollectionViewModel? {
        didSet {
            settingUI()
            settingData()
        }
    }
}

extension JuiceCollectionCell {
    private func settingUI() {
    }
    private func settingData() {
        guard let viewModel: JuiceCollectionViewModel = viewModel else { return }
        juiceDescriptionLabel?.text = viewModel.juiceDescription
    }
}
