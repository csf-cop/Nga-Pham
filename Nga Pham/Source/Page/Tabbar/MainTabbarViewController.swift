//
//  MainTabbarViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class MainTabbarViewController: UITabBarController {

    private var viewModel: MainTabbarViewModel = MainTabbarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadTabbar()
    }

    private func loadTabbar() {
        viewControllers = viewModel.fetchMenus()
    }
}
