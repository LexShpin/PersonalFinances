//
//  AddTransactionViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 13.09.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class AddTransactionViewController: UIViewController {
    
    let db = Firestore.firestore()
    
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
        
//        performSegue(withIdentifier: "unwindToTransactions", sender: self)
        
        if let description = descriptionTextField.text, let amount = amountTextField.text {
            if let amountDouble = Double(amount) {
                db.collection(K.FireStore.transactionsCollection).addDocument(data: [
                    K.FireStore.id: UUID().uuidString,
                    K.FireStore.transactionDescription: description,
                    K.FireStore.transactionAmount: amountDouble,
                    K.FireStore.dateField: Date().timeIntervalSince1970
                ]) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }
    
}

extension AddTransactionViewController: UITextFieldDelegate {
    
}
