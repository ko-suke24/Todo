//
//  TodoEntity + Extension.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/06.
//

import CoreData
import SwiftUI

extension TodoEntity {
    
    static func create(in managedObjectContext: NSManagedObjectContext,
                       category: Category,
                       task: String,
                       time: Date? = Date()){
        let todo = self.init(context: managedObjectContext)
        print(task)
        todo.time = time
        todo.category = category.rawValue
        todo.task = task
        todo.state = State.todo.rawValue
        todo.id = UUID()
        
        do {
            try  managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    enum Category: Int16 {
        case ImpUrg_1st     // Important & Urgent (第Ⅰ領域）
        case ImpNUrg_2nd    // Important & Not Urgent (第Ⅱ領域）
        case NImpUrg_3rd    // Not Important & Urgent（第Ⅲ領域）
        case NImpNUrg_4th   // Not Important & Not Urgent（第Ⅳ領域）
        
        func toString() -> String {
            switch self {
            case .ImpUrg_1st:
                return "仕 事"
            case .ImpNUrg_2nd:
                return "生 活"
            case .NImpUrg_3rd:
                return "趣 味"
            case .NImpNUrg_4th:
                return "買い物"
            }
        }
        func image() -> String {
            switch self {
            case .ImpUrg_1st:
                return "desktopcomputer"
            case .ImpNUrg_2nd:
                return "house.fill"
            case .NImpUrg_3rd:
                return "book.fill"
            case .NImpNUrg_4th:
                return "cart.fill"
            }
        }
        func color() -> Color {
            switch self {
            case .ImpUrg_1st:
                return .tRed
            case .ImpNUrg_2nd:
                return .tBlue
            case .NImpUrg_3rd:
                return .tGreen
            case .NImpNUrg_4th:
                return .tYellow
            }
        }
    }
    
    enum State: Int16 {
        case todo
        case done
    }
    
    static func count(in managedObjectContext: NSManagedObjectContext,
                      category: Category) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoEntity")
        fetchRequest.predicate = NSPredicate(format: "category == \(category.rawValue)")
        
        
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count
        } catch  {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
}
