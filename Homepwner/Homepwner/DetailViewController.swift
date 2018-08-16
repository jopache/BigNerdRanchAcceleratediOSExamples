//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jose Pacheco on 8/15/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: Variabes
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    // MARK: Actions
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        dateField.text = "\(dateFormatter.string(from: item.dateCreated))"
        valueField.text = "\(numberFormatter.string(from: NSNumber(value: item.valueInDollars)) ?? "0.00")"
        
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
        
        view.endEditing(true)
    }
    

    
    // MARK: UITextFieldDelegate members
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageStore.set(image: image, forKey: item.itemKey)
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController {
    func imagePicker(for sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
}
