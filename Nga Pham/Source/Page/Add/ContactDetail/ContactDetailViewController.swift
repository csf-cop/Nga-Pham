//
//  ContactDetailViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class ContactDetailViewController: ViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let viewModel: ContactDetailViewModel = viewModel as? ContactDetailViewModel else { return }
        updateData(model: viewModel)
        viewModel.handleErrorMessage = { [weak self] error in
            self?.showError(error)
        }
    }

    @IBAction func deleteButtonTouchUpInside(_ sender: UIButton) {
        guard let viewModel: ContactDetailViewModel = viewModel as? ContactDetailViewModel else { return }
        viewModel.deleteContact { [] isSuccess in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func editButtonTouchUpInside(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ContactDetailViewController {
    private func updateData(model: ContactDetailViewModel) {
        let defaultImage: UIImage = #imageLiteral(resourceName: "img_no_image")
        if let imageData: Data = (model.contactDetail.avatar?.imageData).unwrapped(or: defaultImage.toData()) {
            avatarImageView.image = UIImage(data: imageData)
        } else {
            avatarImageView.image = #imageLiteral(resourceName: "img_no_image")
        }
        fullNameLabel.text = model.contactDetail.contact.fullName
        phoneLabel.text = model.contactDetail.contact.phone
    }
}
