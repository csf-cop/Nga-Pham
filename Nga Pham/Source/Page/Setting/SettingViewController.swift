//
//  SettingViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet private weak var userInformationButton: UIButton!
    @IBOutlet private weak var syncDataButton: UIButton!
    @IBOutlet private weak var softwareInfoButton: UIButton!

    var viewModel: SettingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func userInfoButtonTouchUpInside(_ sender: UIButton) {
        let vc: UserInformationViewController = UserInformationViewController()
        vc.viewModel = UserInformationViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func syncDataButtonTouchUpInside(_ sender: UIButton) {
        let vc: SyncDataViewController = SyncDataViewController()
        vc.viewModel = SyncDataViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func softwareInfoButtonTouchUpInside(_ sender: UIButton) {
        let vc: SoftwareInfoViewController = SoftwareInfoViewController()
        vc.viewModel = SoftwareInfoViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }
}
