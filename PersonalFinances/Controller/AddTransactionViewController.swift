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
    let defaults = UserDefaults.standard
    
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
        let id = UUID().uuidString
        
        if let description = descriptionTextField.text, let amount = amountTextField.text, let currentUser = Auth.auth().currentUser?.email {
            if let amountDouble = Double(amount) {
                db.collection(K.FireStore.transactionsCollection).document(id).setData([
                    K.FireStore.user: currentUser,
                    K.FireStore.id: id,
                    K.FireStore.transactionDescription: description,
                    K.FireStore.transactionAmount: amountDouble,
                    K.FireStore.dateField: Date().timeIntervalSince1970
                ])
                if let balanceString = defaults.string(forKey: "Balance") {
                    var balanceDouble = Double(balanceString)!
                    balanceDouble -= amountDouble
                    defaults.set(balanceDouble, forKey: "Balance")
                }
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
}

extension AddTransactionViewController: UITextFieldDelegate {
    
}
