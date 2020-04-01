//
//  CoreImage+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/1/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreImage> {
        return NSFetchRequest<CoreImage>(entityName: "CoreImage")
    }

    @NSManaged public var id: String
    @NSManaged public var externalId: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageDateCreate: Date?
    @NSManaged public var imageFileSize: Float
    @NSManaged public var imageIndex: Int16
    @NSManaged public var imageName: String?
    @NSManaged public var imageTypeFor: Int16
    @NSManaged public var isDelete: Bool
}
