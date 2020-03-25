//
//  BaseViewModel.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/21/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BaseViewModel {
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var handleErrorMessage: ((Error) -> Void)?
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let appDelegate: AppDelegate = appDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }

    //        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
    //        print("Path print: \(path.first.unwrapped(or: ""))")
}
