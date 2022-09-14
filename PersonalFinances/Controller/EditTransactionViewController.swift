//
//  EditTransactionViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 13.09.2022.
//

import UIKit
import FirebaseFirestore

class EditTransactionViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var descriptionValue: String?
    var amountValue: String?
    var selectedTransactionIndex: Int!
    var selectedTransactionId: String!
    
    var currentDoc: String!
    
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
        
//        if let description = descriptionTextField.text, let amount = amountTextField.text {
//            if let amountDouble = Double(amount) {
//               let transaction = Transaction(transactionName: description, transactionAmount: amountDouble)
//                delegate?.updateTransaction(transaction: transaction)
//            }
//        }
        
        if let amountDouble = Double(amountTextField.text!), let description = descriptionTextField.text {
            db.collection(K.FireStore.transactionsCollection).whereField(K.FireStore.id, isEqualTo: selectedTransactionId).getDocuments(completion: {(querySnapshot, err) in
                for document in querySnapshot!.documents {
                    print(document)
                    document.reference.updateData([
                        K.FireStore.transactionDescription: description,
                        K.FireStore.transactionAmount: amountDouble,
                    ]) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            })
        }
        
        
//        db.collection(K.FireStore.transactionsCollection).whereField(<#T##field: String##String#>, isEqualTo: <#T##Any#>)
//        db.collection(K.FireStore.transactionsCollection).getDocuments(completion: {(querySnapshot, err) in
//            if let err = err {
//                print(err.localizedDescription)
//            } else {
//                for document in querySnapshot!.documents {
//                    let data = document.data()
//                    if let description = data[K.FireStore.transactionDescription] as? String, let amount = data[K.FireStore.transactionAmount] as? Double {
//                        let amountDouble = Double(self.amountTextField.text!)
//                        if description == self.descriptionTextField.text && amount == amountDouble {
//                            let currentDocument = self.db.collection(K.FireStore.transactionsCollection).document(document.documentID)
//
//                            currentDocument.updateData([
//                                K.FireStore.transactionDescription: description,
//                                K.FireStore.transactionAmount: amountDouble
//                            ]) {err in
//                                if let err = err {
//                                    print(err.localizedDescription)
//                                } else {
//                                    print("Document updated")
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        })
    }
}

extension EditTransactionViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
