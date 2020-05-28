//
//  ProductDetailsVC.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class ProductDetailsVC: UITableViewController {

    var categoryDetail:Category?
    @IBOutlet weak var categoryDetailName: UILabel!
    var index = Int()
    @IBOutlet weak var dishesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryDetailName.text = categoryDetail?.name
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryDetailName.text = categoryDetail?.name
        if let dishes = categoryDetail?.dishes?.allObjects as? [Dishes] {
            dishesLabel.text = "\(dishes.count)"
        } else {
            dishesLabel.text = "0"
        }
    }
    
    @IBAction func editTapped(_ sender: Any) {
        
        let formVC = self.storyboard?.instantiateViewController(identifier: "CategoryFormVC") as! CategoryFormVC
        formVC.isUpdate = true
        
        formVC.CategoryDetails = categoryDetail
        formVC.indexRow = index
        self.navigationController?.pushViewController(formVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let dishListVC = (self.storyboard?.instantiateViewController(identifier: "DishesListVC"))! as DishesListVC
            dishListVC.category = categoryDetail
            self.navigationController?.pushViewController(dishListVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
}
