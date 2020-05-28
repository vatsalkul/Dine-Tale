//
//  ProductsViewController.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrCategory:[Category] = []
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.arrCategory = DatabaseHelper.sharedInstance.getCategory()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrCategory = DatabaseHelper.sharedInstance.getCategory()
        self.tableView.reloadData()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let categortFormVC = self.storyboard?.instantiateViewController(identifier: "CategoryFormVC") as! CategoryFormVC
        navigationController?.pushViewController(categortFormVC, animated: true)
    }
}
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        cell.catName.text = arrCategory[indexPath.row].name
        cell.catImg.image = UIImage(data: arrCategory[indexPath.row].image!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrCategory = DatabaseHelper.sharedInstance.deleteCategory(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsVC
        detailVC.categoryDetail = arrCategory[indexPath.row]
        detailVC.index = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}
