//
//  TransactionsViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class TransactionsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var spentLabel: UILabel!
    
    let db = Firestore.firestore()
    
    var transactions: [Transaction] = []
    
    var selectedTransaction: Transaction?
    var selectedTransactionIndex: Int!
    
    let budgetViewController = BudgetViewController()
    let editTransactionViewController = EditTransactionViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        loadTransactions()
    }
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
    }
    
    
    func updateAmountSpent(transactions: [Transaction]) {
        var totalSpent: Double = 0.0
        
        db.collection(K.FireStore.transactionsCollection).getDocuments(completion: {(querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    if data[K.FireStore.user] as! String == Auth.auth().currentUser?.email {
                        if let amount = data[K.FireStore.transactionAmount] as? Double {
                            totalSpent += amount
                        }
                    }
                }
                self.spentLabel.text = String(format: "%.2f", totalSpent)
            }
        })
        
    }
    
    @IBAction func addTransactionPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.transactionsToAddTransaction, sender: self)
    }
    
    func loadTransactions() {
        
        self.transactions = []
        
        db.collection(K.FireStore.transactionsCollection)
            .order(by: K.FireStore.dateField)
            .getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error loading documents")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if data[K.FireStore.user] as! String == Auth.auth().currentUser?.email {
                        if let description = data[K.FireStore.transactionDescription] as? String, let amount = data[K.FireStore.transactionAmount] as? Double, let id = data[K.FireStore.id] as? String {
                            let newTransaction = Transaction(id: id, transactionName: description, transactionAmount: amount)
                            self.transactions.append(newTransaction)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        })
        updateAmountSpent(transactions: transactions)
        tableView.reloadData()
    }
    
}

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
            cell.transactionName.text = "\(transactions[indexPath.row].transactionName)"
            cell.transactionAmount.text = "$\(transactions[indexPath.row].transactionAmount)"
            
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // delete the item from the tableview
        // delete the item from the firebase
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTransaction = transactions[indexPath.row]
        selectedTransactionIndex = indexPath.row
        
        performSegue(withIdentifier: K.transactionsToEditTransaction, sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.transactionsToEditTransaction {
            if let vc = segue.destination as? EditTransactionViewController {
                if let transactionAmountString = selectedTransaction?.transactionAmount {
                    vc.descriptionValue = selectedTransaction?.transactionName
                    vc.amountValue = String(transactionAmountString)
                    vc.selectedTransactionIndex = selectedTransactionIndex
                    vc.selectedTransactionId = selectedTransaction?.id
                }
            }
        }
    }
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
}
