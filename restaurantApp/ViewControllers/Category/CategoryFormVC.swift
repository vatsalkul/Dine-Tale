//
//  AddCategoryVC.swift
//  restaurantApp
//
//  Created by Vatsal Kulshreshtha on 13/05/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class CategoryFormVC: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var CategoryDetails: Category?
    var isUpdate = false
    var indexRow = Int()
    let placeholderImage = UIImage(systemName: "photo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryNameTextField.text = CategoryDetails?.name
        self.categoryImageView.image = UIImage(data: (CategoryDetails?.image ?? placeholderImage?.jpegData(compressionQuality: 0.75))!)
        categoryImageView.layer.cornerRadius = 10
        addImageButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isUpdate {
            saveButton.title = "Update"
        } else {
            saveButton.title = "Save"
        }
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        self.openImagePicker()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if categoryNameTextField.text!.isEmpty || categoryNameTextField.text == "" {
            showAlert(title: "Enter Name", message: "Please add category name")
        } else {
            if let jpeg = self.categoryImageView.image?.jpegData(compressionQuality: 0.75) {
                if isUpdate {
                    DatabaseHelper.sharedInstance.editCategory(name: categoryNameTextField.text!, image: jpeg, index: indexRow)
                    isUpdate = false
                } else {
                    DatabaseHelper.sharedInstance.saveCategory(name: categoryNameTextField.text!, image: jpeg)
                }
                 
        }
           self.navigationController?.popViewController(animated: true)
            
        }
        
    }

}
extension CategoryFormVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
            self.categoryImageView.image = img
        }
    }
    
}

