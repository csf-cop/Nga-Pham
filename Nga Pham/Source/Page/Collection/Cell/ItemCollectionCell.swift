//
//  ItemCollectionCell.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class ItemCollectionCell: UITableViewCell {

    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemDescriptionLabel: UILabel!

    var viewModel: ItemCollectionCellModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ItemCollectionCell {
    private func updateView() {
        guard let viewModel: ItemCollectionCellModel = viewModel else { return }
        itemDescriptionLabel.text = viewModel.description
    }
}
