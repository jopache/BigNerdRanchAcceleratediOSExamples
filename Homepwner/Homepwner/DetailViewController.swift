//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jose Pacheco on 8/15/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
    alertController.popoverPresentationController?.barButtonItem = sender
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            print ("present camera library")
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            print("Present photolibrary")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    // MARK: outlets and variables
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    
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
    
    // MARK: Actions
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        dateField.text = "\(dateFormatter.string(from: item.dateCreated))"
        valueField.text = "\(numberFormatter.string(from: NSNumber(value: item.valueInDollars)) ?? "0.00")"
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
}
