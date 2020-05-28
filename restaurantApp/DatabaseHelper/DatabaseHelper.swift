//
//  DatabaseHelper.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 12/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {

    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveCategory(name: String, image: Data) {
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as! Category
        category.name = name
        category.image = image
        
        do {
            try context.save()
        } catch {
            print("Cannot save category")
        }
        
    }
    
    func getCategory() -> [Category] {
        var arrCategory = [Category]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        
        do {
            arrCategory = try context.fetch(fetchRequest) as! [Category]
        } catch {
            print("Error in fetching category")
        }
        return arrCategory
    }
    
    func deleteCategory(index: Int) -> [Category] {
        
        var category = self.getCategory()
        context.delete(category[index])
        category.remove(at: index)

        do {
            try context.save()
        } catch {
            print("Cannot delete category")
        }
        
        return category
        
    }
    
    func editCategory(name: String, image: Data, index: Int) {
        let categories = self.getCategory()
        categories[index].name = name
        categories[index].image = image
        do {
            try context.save()
        } catch {
            print("Cannot edit category data")
        }
    }
    
    func saveDish(object: [String:String], image: Data, category: Category) {
        let dish = NSEntityDescription.insertNewObject(forEntityName: "Dishes", into: context) as! Dishes
        dish.name = object["name"]
        dish.price = object["price"]
        dish.desc = object["description"]
        dish.image = image
        dish.category = category
        
        do {
            try context.save()
        } catch {
            print("Cannot save dish")
        }
    }
  
    
    
    
    func deleteDish(index: Int, category: Category) -> [Dishes] {
        
        var dishes = category.dishes?.allObjects as! [Dishes]
        
//        var dishes = self.getDishes()
        context.delete(dishes[index])
        dishes.remove(at: index)

        do {
            try context.save()
        } catch {
            print("Cannot delete dish data")
        }
        
        return dishes
        
    }
    
    func editDish(object: [String:String], category: Category, index: Int, image: Data) {
        let dishes = category.dishes?.allObjects as! [Dishes]
        dishes[index].name = object["name"]
        dishes[index].image = image
        dishes[index].desc = object["description"]
        dishes[index].price = object["price"]
        
        do {
            try context.save()
        } catch {
            print("Cannot edit dish")
        }
    }
    
    func saveEmployee(employeeName: String) -> Employee {
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.name = employeeName
        
        do {
            try context.save()
        } catch {
            print("Cannot save employee")
        }
        return employee
    }
    
    func getEmployes() -> [Employee] {
        var arrEmployee = [Employee]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        do {
            arrEmployee = try context.fetch(fetchRequest) as! [Employee]
        } catch {
            print("Error in fetching employee")
        }
        return arrEmployee
    }
    
    func saveOrder(object: [String:String]) {
        let order = NSEntityDescription.insertNewObject(forEntityName: "Orders", into: context) as! Orders
        order.amount = object["amount"]
        order.table = object["table"]
        order.items = object["items"]
        order.employee = object["employee"]
        
        do {
            try context.save()
        } catch {
            print("Cannot save order")
        }
    }
    
    func getOrders() -> [Orders] {
        var arrOrders = [Orders]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Orders")
        
        do {
            arrOrders = try context.fetch(fetchRequest) as! [Orders]
        } catch {
            print("Error in fetching orders")
        }
        return arrOrders
    }
    
}
