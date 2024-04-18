//
//  CoreDataManager.swift
//  WishList
//
//  Created by 김정호 on 4/18/24.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    // MARK: - properties
    static let shared = CoreDataManager()
    private init() { }
    
    private let modelName = "Product"
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - methods
    func fetchProducts() -> [Product] {
        var products: [Product] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            do {
                if let fetchedProducts = try context.fetch(request) as? [Product] {
                    products = fetchedProducts
                }
            } catch {
                return products
            }
        }
        
        return products
    }
    
    func contains(productDTO: ProductDTO) -> Bool {
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id == %d", Int16(productDTO.id))
            
            do {
                if let fetchedProducts = try context.fetch(request) as? [Product] {
                    return (productDTO.id == (fetchedProducts.first?.id ?? -1)) ? true : false
                }
            } catch {
                return false
            }
        }
        
        return false
    }
    
    func saveProduct(productDTO: ProductDTO, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let product = NSManagedObject(entity: entity, insertInto: context) as? Product {
                    product.id = Int16(productDTO.id)
                    product.title = productDTO.title
                    product.information = productDTO.information
                    product.price = productDTO.price
                    product.thumbnail = productDTO.thumbnail
                    
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    func deleteProduct(product: Product, completion: @escaping () -> Void) {
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id == %d", Int16(product.id))
            
            do {
                if let fetchedProduct = try context.fetch(request) as? [Product] {
                    if let targetProduct = fetchedProduct.first {
                        context.delete(targetProduct)
                        appDelegate?.saveContext()
                    }
                }
                completion()
            } catch {
                print(error)
                completion()
            }
        }
    }
}
