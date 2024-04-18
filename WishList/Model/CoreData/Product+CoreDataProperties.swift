//
//  Product+CoreDataProperties.swift
//  WishList
//
//  Created by 김정호 on 4/18/24.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int16
    @NSManaged public var information: String?
    @NSManaged public var price: Double
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?

}

extension Product : Identifiable {

}
