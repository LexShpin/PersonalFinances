//
//  EditTransactionViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 13.09.2022.
//

import UIKit

protocol EditTransactionProtocol: AnyObject {
    func updateTransaction(transaction: Transaction)
}

class EditTransactionViewController: UIViewController, UITextFieldDelegate {
    
    var descriptionValue: String?
    var amountValue: String?
    var selectedTransactionIndex: Int!
    
    weak var delegate: EditTransactionProtocol?
    
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextField.delegate = self
        amountTextField.delegate = self

        descriptionTextField.text = descriptionValue
        amountTextField.text = amountValue
    }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        if let description = descriptionTextField.text, let amount = amountTextField.text {
            if let amountDouble = Double(amount) {
               let transaction = Transaction(transactionName: description, transactionAmount: amountDouble)
                delegate?.updateTransaction(transaction: transaction)
            }
        }
        
    }
}
