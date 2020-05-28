//
//  OrdersViewController.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var orders: [Orders]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.orders = DatabaseHelper.sharedInstance.getOrders()
    }
    

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.amountLabel.text = orders![indexPath.row].amount
        cell.employeeLabel.text = orders![indexPath.row].employee
        cell.itemsLabel.text = orders![indexPath.row].items
        cell.tableLabel.text = orders![indexPath.row].table
        return cell
    }

    
    
}
