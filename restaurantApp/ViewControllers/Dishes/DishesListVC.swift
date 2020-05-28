//
//  DishesListVC.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class DishesListVC: UIViewController, popupAddDish {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrDishes: [Dishes]?
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.arrDishes = category?.dishes?.allObjects as? [Dishes]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if category?.dishes?.allObjects != nil {
            arrDishes = category?.dishes?.allObjects as? [Dishes]
        }
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let dishFormVC = self.storyboard?.instantiateViewController(identifier: "DishesFormVC") as! DishesFormVC
        dishFormVC.delegate = self
        dishFormVC.category = category
        present(dishFormVC, animated: true, completion: nil)
        
    }
    
   

}
extension DishesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath)
        
        cell = UITableViewCell(style: .value2, reuseIdentifier: "DishCell")

        cell.textLabel?.text = arrDishes?[indexPath.row].price
        cell.detailTextLabel?.text = arrDishes?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrDishes = DatabaseHelper.sharedInstance.deleteDish(index: indexPath.row, category: category!)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dishesFormVC = self.storyboard?.instantiateViewController(identifier: "DishesFormVC") as! DishesFormVC
        dishesFormVC.delegate = self
        dishesFormVC.isUpdate = true
        dishesFormVC.dish = arrDishes![indexPath.row]
        dishesFormVC.indexRow = indexPath.row
        dishesFormVC.category = category
        present(dishesFormVC, animated: true, completion: nil)
        
    }
    
    
}
extension DishesListVC {
    func dishAdded() {
        if category?.dishes?.allObjects != nil {
            arrDishes = category?.dishes?.allObjects as? [Dishes]
        }
        self.tableView.reloadData()
    }
}
