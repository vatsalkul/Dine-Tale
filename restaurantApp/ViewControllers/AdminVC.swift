//
//  AdminVC.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class AdminVC: UIViewController {
    

    @IBOutlet weak var ordersButoon: UIButton!
    @IBOutlet weak var productButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersButoon.layer.cornerRadius = 10
        productButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }


}
