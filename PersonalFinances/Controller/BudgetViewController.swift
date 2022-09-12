//
//  ViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet var totalBalanceLabel: UILabel!
    
    var transactions = Transactions()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
    }

}

extension BudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.recentTransactions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
        cell.transactionName.text = "\(transactions.transactionsArr[indexPath.row].transactionName)"
        cell.transactionAmount.text = "$\(transactions.transactionsArr[indexPath.row].transactionAmount)"
        
        return cell
    }
    
    
}
