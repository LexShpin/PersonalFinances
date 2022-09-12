//
//  ViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet var currencyPopUpButton: UIButton!
    @IBOutlet var totalBalanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPopUpButton.menu = UIMenu(children: [
            UIAction(title: "USD", state: .on, handler: optionClosure),
            UIAction(title: "MXN", state: .on, handler: optionClosure),
            UIAction(title: "Option 3", state: .on, handler: optionClosure)
        ])
        
        currencyPopUpButton.showsMenuAsPrimaryAction = true
        currencyPopUpButton.changesSelectionAsPrimaryAction = true
    }

    let optionClosure = {(action: UIAction) in
        print(action.title)
        
    }
    
//    currencyPopUp.menu = UIMenu(children: [
//        UIAction(title: "Option 1", state: .on, handler: optionClosure),
//        UIAction(title: "Option 2", state: .on, handler: optionClosure),
//        UIAction(title: "Option 3", state: .on, handler: optionClosure)
//    ])

}

