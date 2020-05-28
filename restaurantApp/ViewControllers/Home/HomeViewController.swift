//
//  HomeViewController.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 11/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var employee: String = String()
    var arrCategory:[Category] = []
    var unwinding = false
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navItem: UINavigationItem!

    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        self.unwinding = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrCategory = DatabaseHelper.sharedInstance.getCategory()
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
        employee = UserDefaults.standard.string(forKey: "Employee")!
        navItem.title = employee
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.arrCategory = DatabaseHelper.sharedInstance.getCategory()
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.unwinding) {
            self.showAlert(title: "Thanks!", message: "Order Placed")
            self.unwinding=false
        }
    }

    
    @IBAction func endShiftTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "ISLOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width-30, height: bounds.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuVC = self.storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        menuVC.category = arrCategory[indexPath.row]
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = arrCategory[indexPath.row].name
        cell.categoryimage.image = UIImage(data: arrCategory[indexPath.row].image!)
        cell.categoryimage.layer.cornerRadius = 15
        cell.bgView.layer.cornerRadius = 10
        
        
        
        return cell
    }
    
}
