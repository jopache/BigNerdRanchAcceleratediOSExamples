//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Jose Pacheco on 8/14/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    // MARK: Instance Variables
    var itemStore: ItemStore!
    
    
    // MARK: Overridden methods
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.serialNumberLabel.text = item.serialNumber
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem":
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: Actions
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
