//
//  ViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet var totalBalanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension BudgetViewController: UITableViewDataSource {
    
}
