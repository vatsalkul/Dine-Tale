//
//  OrderReviewVC.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 18/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class OrderReviewVC: UIViewController {

    var orderedItems: [Dishes]?
    var total = 0
    var itemsList: String? = ""
    @IBOutlet weak var tableNumbetTextField: UITextField!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        for items in orderedItems! as [Dishes] {
            total += Int(String(items.price!))!
            itemsList = itemsList! + items.name! + ","
        }
        totalAmountLabel.text = "₹" + String(total)
        
        setupKeyboard()
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        guard let amount = totalAmountLabel.text else { return }
        guard let table = tableNumbetTextField.text else { return }
        guard let items = itemsList else { return }
        guard let employee = UserDefaults.standard.string(forKey: "Employee") else { return }
        
        let order = ["amount": amount, "table": table, "items": items, "employee":employee]
        DatabaseHelper.sharedInstance.saveOrder(object: order)
        
        self.performSegue(withIdentifier: "unwindId", sender: self)
        
        
    }
    
    func setupKeyboard() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        
        tableNumbetTextField.inputAccessoryView = toolbar
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}
extension OrderReviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        cell = UITableViewCell(style: .value2, reuseIdentifier: "DishCell")
        cell.textLabel?.text = "₹" + orderedItems![indexPath.row].price!
        cell.detailTextLabel?.text = orderedItems![indexPath.row].name
        cell.detailTextLabel?.textColor = .systemIndigo
        cell.textLabel?.textColor = .label
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            orderedItems?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
