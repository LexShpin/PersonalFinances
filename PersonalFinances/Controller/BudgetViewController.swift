//
//  ViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class BudgetViewController: UIViewController {

    @IBOutlet var totalBalanceLabel: UILabel!
    
    var transactions = Transactions()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
    }

    @IBAction func setBalancePressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Set your budget", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {[weak self, weak ac] action in
            if let answer = ac?.textFields?[0].text {
                self?.totalBalanceLabel.text = answer
            }
        })
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
    
}

extension BudgetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.recentTransactions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
        
//        var transactionsReversed: [Transaction] = transactions.reversed()
//        
//        cell.transactionName.text = "\(transactionsReversed[indexPath.row].transactionName)"
//        cell.transactionAmount.text = "$\(transactionsReversed[indexPath.row].transactionAmount)"
//        
        return cell
    }
    
    
}
