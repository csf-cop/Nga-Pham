//
//  ContactViewCell.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class ContactViewCell: UICollectionViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var contactNameLabel: UILabel!
    
    var viewModel: ContactCellModel? {
        didSet {
            guard let viewModel: ContactCellModel = viewModel else { return }
            updateData(model: viewModel)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ContactViewCell {
    private func updateData(model: ContactCellModel) {
        contactNameLabel.text = model.fullName
        if let imageData: Data = model.avatar {
            avatarImageView.image = UIImage(data: imageData)
        } else {
            avatarImageView.image = #imageLiteral(resourceName: "img_no_image")
        }
    }
}
