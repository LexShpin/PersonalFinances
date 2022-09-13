//
//  TransactionsViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import Foundation
import UIKit

class TransactionsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var spentLabel: UILabel!
    
    var transactions = Transactions()
    var selectedTransaction: Transaction?
    var selectedTransactionIndex: Int!
    
    var addTransaction = AddTransactionViewController()
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToaddTransaction))

        addTransaction.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
        
        updateAmountSpent(transactions: transactions)
    }
    
    
    func updateAmountSpent(transactions: Transactions) {
        var totalSpent: Double = 0.0
        transactions.transactionsArr.map {totalSpent += $0.transactionAmount}
        spentLabel.text = String(format: "%.2f", totalSpent)
    }
    
    @objc func goToaddTransaction() {
        performSegue(withIdentifier: K.transactionsToAddTransaction, sender: self)
    }
}

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.transactionsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
            cell.transactionName.text = "\(transactions.transactionsArr[indexPath.row].transactionName)"
            cell.transactionAmount.text = "$\(transactions.transactionsArr[indexPath.row].transactionAmount)"
            
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // delete the item from the tableview
        // delete the item from the firebase
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTransaction = transactions.transactionsArr[indexPath.row]
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
                    vc.delegate = self
                }
            }
        }
    }
    
}

extension TransactionsViewController: EditTransactionProtocol {
    func updateTransaction(transaction: Transaction) {
        transactions.transactionsArr[selectedTransactionIndex] = transaction
        updateAmountSpent(transactions: transactions)
        tableView.reloadData()
    }
}

extension TransactionsViewController: AddTransactionProtocol {
    func addTransaction(transaction: Transaction) {
        print("it worked")
    }
}
