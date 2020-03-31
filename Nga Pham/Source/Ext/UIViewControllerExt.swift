//
//  UIViewControllerExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.isEmpty {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }

    func alert(title: String = "", message: String, completion: ((Int) -> Void)? = nil) {
        showAlert(title: title, message: message, buttonTitles: ["OK"], completion: completion)
    }

    func showError(_ error: Error, completion: ((Int) -> Void)? = nil) {
        var messageError = error.localizedDescription
//        if let msg = (error as? ApiError)?.message {
//            messageError = msg
//        }
        alert(message: messageError, completion: completion)
    }
}

extension UIViewController {
    func showIndicator(toView: UIView? = nil, position: CGPoint = CGPoint(x: 0, y: 0), bezelViewBackgroudColor color: UIColor? = nil) {
        let hud: MBProgressHUD
        if let toView = toView {
            hud = MBProgressHUD.showAdded(to: toView, animated: true)
        } else {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        hud.offset = position
        if color != nil {
            hud.bezelView.backgroundColor = color
        }
    }

    func hideIndicator(forView: UIView? = nil) {
        if let forView = forView {
            MBProgressHUD.hide(for: forView, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
