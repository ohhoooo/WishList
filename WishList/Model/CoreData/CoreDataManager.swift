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
    
    private let modelname = "Product"
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - methods
}
