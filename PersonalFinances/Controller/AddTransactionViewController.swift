//
//  AddTransactionViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 13.09.2022.
//

import UIKit

protocol AddTransactionProtocol: AnyObject {
    func addTransaction(transaction: Transaction)
}

class AddTransactionViewController: UIViewController {
    
    weak var delegate: AddTransactionProtocol?
    
    var descriptionValue: String?
    var amountValue: String?

    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextField.delegate = self
        amountTextField.delegate = self
        
        descriptionTextField.text = descriptionValue
        amountTextField.text = amountValue
    }
    
    @IBAction func addTransactionPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        if let description = descriptionTextField.text, let amount = amountTextField.text {
            if let amountDouble = Double(amount) {
                let transaction = Transaction(transactionName: description, transactionAmount: amountDouble)
                delegate?.addTransaction(transaction: transaction)
            }
        }
    }

}

extension AddTransactionViewController: UITextFieldDelegate {
    
}
