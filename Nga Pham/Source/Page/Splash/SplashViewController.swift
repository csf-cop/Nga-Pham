//
//  SplashViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {

    @IBOutlet private weak var logoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

extension SplashViewController {
    private func configUI() {
        // MARK: Text color and size.
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.checkHomeConditions))
        logoView.addGestureRecognizer(gesture)
    }

    @objc private func checkHomeConditions() {
        let root: MainTabbarViewController = MainTabbarViewController()
        let navi: UINavigationController = UINavigationController(rootViewController: root)
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = navi
    }
}
