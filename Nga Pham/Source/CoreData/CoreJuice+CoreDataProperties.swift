//
//  CoreJuice+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/26/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreJuice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreJuice> {
        return NSFetchRequest<CoreJuice>(entityName: "CoreJuice")
    }

    @NSManaged public var dateCreate: Date?
    @NSManaged public var id: String?
    @NSManaged public var isDelete: Bool
    @NSManaged public var juiceDescription: String?
    @NSManaged public var juiceMorePhotos: Data?
    @NSManaged public var juiceName: String?
    @NSManaged public var juicePhotoId: String?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var unitId: String?

}
