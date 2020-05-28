//
//  AdminViewController.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 12/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    var selectedItem:[Int] = []
    var selectedDish: [Dishes] = []
    var dishes: [Dishes]?
    var category: Category?
    
    @IBOutlet weak var totalView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var total = 0
    @IBOutlet weak var reviewButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalView.layer.cornerRadius = 10
        self.dishes = category?.dishes?.allObjects as? [Dishes]
        reviewButton.layer.cornerRadius = 5
        configureCollectionView()
        
    }
    
    
     func configureCollectionView() {
         collectionView.delegate = self
         collectionView.dataSource = self
        
     }
    
    @IBAction func reviewButtonTapped(_ sender: Any) {
        let destVC = self.storyboard?.instantiateViewController(identifier: "OrderReviewVC") as! OrderReviewVC
        destVC.orderedItems = selectedDish
        present(destVC, animated: true, completion: nil)
        
    }
    

}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2, height: bounds.height/3 + 10)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as! DishesCell
        cell.dishName.text = dishes![indexPath.row].name
        cell.dishDescription.text = dishes![indexPath.row].desc
        cell.dishImage.image = UIImage(data: dishes![indexPath.row].image!)
        cell.dishPrice.text = "₹" + dishes![indexPath.row].price!
        cell.dishImage.layer.cornerRadius = 10
        
        if self.selectedItem.contains(indexPath.row) {
            cell.selectionView.isHidden = false
        } else {
            cell.selectionView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedItem.contains(indexPath.row) {
            self.selectedDish.remove(at: self.selectedItem.firstIndex(of: indexPath.row)!)
            self.selectedItem.remove(at: self.selectedItem.firstIndex(of: indexPath.row)!)
            
            collectionView.reloadData()
            
            total -= Int(String(dishes![indexPath.row].price!))!
            totalPriceLabel.text = "Total: \(total)"
        } else {
            self.selectedItem.append(indexPath.row)
            self.selectedDish.append(dishes![indexPath.row])
            collectionView.reloadData()
            total += Int(String(dishes![indexPath.row].price!))!
            totalPriceLabel.text = "Total: \(total)"
        }
        
    }
}
