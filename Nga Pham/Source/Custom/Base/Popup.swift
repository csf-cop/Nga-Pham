//
//  Popup.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class Popup: UIViewController {

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
}

// MARK: - NotificationCenter
extension Popup: UIGestureRecognizerDelegate {
    func notificationReloadData(notiReloadData: [NotiReloadData], userInfo: [String: Any]? = nil) {
        notiReloadData.forEach {
            notificationCenter.post(name: $0.name(), object: nil, userInfo: userInfo)
        }
    }
}
