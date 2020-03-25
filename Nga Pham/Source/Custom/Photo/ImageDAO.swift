//
//  ImageDAO.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/21/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import CoreData
import UIKit

/// Saves and loads images from CoreData.
class ImageDAO {
    private let container: NSPersistentContainer
    private let imageStorage: ImageStorage

    init(container: NSPersistentContainer, imageStorage: ImageStorage) {
        self.container = container
        self.imageStorage = imageStorage
    }

    func makeExternallyStoredImage(_ bitmap: UIImage) -> CoreImage {
        let image: CoreImage = insert(CoreImage.self, into: container.viewContext)
        image.imageData = bitmap.pngData()
        saveContext()
        return image
    }

    func externallyStoredImage(by id: NSManagedObjectID) -> CoreImage {
        return container.viewContext.object(with: id) as! CoreImage
    }

    private func saveContext() {
        try! container.viewContext.save()
    }
    
    private func insert<T>(_ type: T.Type, into context: NSManagedObjectContext) -> T {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
    }
}
