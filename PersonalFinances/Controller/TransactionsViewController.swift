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
    
    var transactions = Transactions()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
    }
    
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.transactionsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
            cell.transactionName.text = transactions.transactionsArr[indexPath.row].transactionName
            cell.transactionAmount.text = String(transactions.transactionsArr[indexPath.row].transactionAmount)
            
            return cell
        
    }
}
