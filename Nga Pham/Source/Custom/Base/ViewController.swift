//
//  ViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/27/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: BaseViewModel?

    func hideBackButtonText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func configLeftButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(leftButtonTouchUpInside))
    }

    @objc func leftButtonTouchUpInside() { }

    func enableUserInteraction(isEnable: Bool) {
        view.isUserInteractionEnabled = isEnable
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    @objc func getUIScrollView() -> UIScrollView? {
        return nil
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func notificationReloadData(notiReloadData: [NotiReloadData], userInfo: [String: Any]? = nil) {
        notiReloadData.forEach {
            notificationCenter.post(name: $0.name(), object: nil, userInfo: userInfo)
        }
    }
}
