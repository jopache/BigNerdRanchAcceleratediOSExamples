//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jose Pacheco on 8/15/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    
    var item: Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        dateField.text = "\(dateFormatter.string(from: item.dateCreated))"
        valueField.text = "$\(numberFormatter.string(from: NSNumber(value: item.valueInDollars)) ?? "0.00")"
    }
    
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
}
