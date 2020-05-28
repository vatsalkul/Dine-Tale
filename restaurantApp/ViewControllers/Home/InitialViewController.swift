//
//  ViewController.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 11/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    var pickerData: [String] = [String]()
    var valueSelected = ""
    var arrEmployee = [Employee]()
    var isPickerViewHidden = true
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 25
        arrEmployee = DatabaseHelper.sharedInstance.getEmployes()
        startButton.layer.cornerRadius = 15
        startButton.clipsToBounds = true
        if arrEmployee.isEmpty {
            showAlert(title: "Add Employee", message: "Please add employee")
        } else {
            //            pickerView.isHidden = false
        }
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.bool(forKey: "ISLOGGEDIN") == true {
            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Employee", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text else { return }
            if name == "" {
                print("no")
                self.showAlert(title: "Enter valid name", message: "")
                return
            }
            let emp = DatabaseHelper.sharedInstance.saveEmployee(employeeName: name)
            
            self.arrEmployee.append(emp)
            self.pickerView.reloadAllComponents()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        valueSelected = (arrEmployee[selectedRow].name!) as String
        UserDefaults.standard.set(valueSelected, forKey: "Employee")
        
        UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
        let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC")
        self.navigationController?.pushViewController(homeVC!, animated: true)
    }
    
}


extension InitialViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrEmployee.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrEmployee[row].name
        
    }
     
}


