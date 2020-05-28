//
//  DishesFormVC.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

protocol popupAddDish {
    func dishAdded()
}

class DishesFormVC: UIViewController {

    @IBOutlet weak var dishName: UITextField!
    @IBOutlet weak var dishDescription: UITextField!
    @IBOutlet weak var dishPrice: UITextField!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var isUpdate = false
    var delegate: popupAddDish?
    var category: Category?
    var dish: Dishes?
    let imagePicker = UIImagePickerController()
    var indexRow = Int()
    let placeholderImage = UIImage(systemName: "photo")
    override func viewDidLoad() {
        super.viewDidLoad()
        dishName.text = dish?.name
        dishDescription.text = dish?.desc
        dishPrice.text = dish?.price
        dishImage.image = UIImage(data: (dish?.image ?? placeholderImage?.jpegData(compressionQuality: 0.75))!)
        addImageButton.layer.cornerRadius = 5
        dishImage.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isUpdate {
            saveButton.title = "Update"
        } else {
            saveButton.title = "Save"
        }
    }
    @IBAction func addImgaeTapped(_ sender: Any) {
        
        self.openImagePicker()
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = dishName.text else { return }
        guard let desc = dishDescription.text else { return }
        guard let price = dishPrice.text else { return }
        guard let category = category else { return }
        
        let dishDetail = ["name": name,"description": desc , "price": price]
        
        if dishName.text!.isEmpty || dishDescription.text!.isEmpty || dishPrice.text!.isEmpty {
            showAlert(title: "Could not proceed", message: "Please enter all fields")
        } else {
            if let jpeg = self.dishImage.image?.jpegData(compressionQuality: 0.75) {
                if isUpdate {
                    DatabaseHelper.sharedInstance.editDish(object: dishDetail, category: category, index: indexRow, image: jpeg)
                    isUpdate = false
                } else {
                     DatabaseHelper.sharedInstance.saveDish(object: dishDetail, image: jpeg, category: category)
                }
               delegate?.dishAdded()
            }
            
            dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    
    
    @IBAction func cencelTapped(_ sender: Any) {
        if let presenter = presentingViewController as? DishesListVC {
            presenter.tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    

}
extension DishesFormVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            self.dishImage.image = img
        }
    }
    
}
