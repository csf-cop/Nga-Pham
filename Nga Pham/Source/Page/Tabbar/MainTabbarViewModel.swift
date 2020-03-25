//
//  MainTabbarViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import UIKit

final class MainTabbarViewModel {
    private var menus: [UIViewController] = []
}

extension MainTabbarViewModel {
    func fetchMenus() -> [UIViewController] {
        var menuResponse: [UIViewController] = []
        for item: MenuType in MenuType.allCases {
            let vc: UIViewController = item.controller
            vc.title = item.title
            let tabbarItemVC: UINavigationController = UINavigationController(rootViewController: vc)
            tabbarItemVC.tabBarItem = UITabBarItem(title: item.title, image: item.normalImage.withRenderingMode(.alwaysOriginal), selectedImage: item.selectedImage)
            menuResponse.append(tabbarItemVC)
        }
        
        return menuResponse
    }
}

extension MainTabbarViewModel {
    enum MenuType: CaseIterable {
        case home
        case collection
        case contact
        case setting

        init?(rawValue: Int) {
            switch rawValue {
            case 0: self = .home
            case 1: self = .collection
            case 2: self = .contact
            case 3: self = .setting
            default: return nil
            }
        }

        var controller: UIViewController {
            switch self {
            case .home:
                let home: HomeViewController = HomeViewController()
                home.viewModel = HomeViewModel()
                let item = UITabBarItem()
                item.title = title
                home.tabBarItem = item
                return home
            case .collection:
                let collection: ItemCollectionViewController = ItemCollectionViewController()
                collection.viewModel = ItemCollectionViewModel()
                collection.title = title
                return collection
            case .contact:
                let contact: ContactViewController = ContactViewController()
                contact.viewModel = ContactViewModel()
                contact.title = title
                return contact
            case .setting:
                let setting: SettingViewController = SettingViewController()
                setting.viewModel = SettingViewModel()
                setting.title = title
                return setting
            }
        }

        var title: String {
            switch self {
            case .home: return "Trang chủ"
            case .collection: return "Danh sách đặt hàng"
            case .contact: return "Danh bạ"
            case .setting: return "Thiết lập"
            }
        }

        var normalImage: UIImage {
            switch self {
            case .home:
                return #imageLiteral(resourceName: "home-icon")
            case .collection:
                return #imageLiteral(resourceName: "collection-icon")
            case .contact:
                return #imageLiteral(resourceName: "contact-icon")
            case .setting:
                return #imageLiteral(resourceName: "setting-icon")
            }
        }

        var selectedImage: UIImage {
            switch self {
            case .home:
                return #imageLiteral(resourceName: "home-icon")
            case .collection:
                return #imageLiteral(resourceName: "collection-icon")
            case .contact:
                return #imageLiteral(resourceName: "contact-icon")
            case .setting:
                return #imageLiteral(resourceName: "setting-icon")
            }
        }
    }
}
