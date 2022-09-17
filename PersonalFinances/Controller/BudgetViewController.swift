//
//  ViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class BudgetViewController: UIViewController {

    @IBOutlet var totalBalanceLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard
    var transactions = Transactions().transactions
    
    override func viewWillAppear(_ animated: Bool) {
        updateBalance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
        
        updateBalance()
    }

    @IBAction func setBalancePressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Set your budget", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {[weak self, weak ac] action in
            if let answer = ac?.textFields?[0].text {
                self?.defaults.set(answer, forKey: "Balance")
                if let balanceString = self?.defaults.string(forKey: "Balance") {
                    self?.totalBalanceLabel.text = balanceString
                }
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
    
    func updateBalance() {
        if let balanceString = defaults.string(forKey: "Balance") {
            totalBalanceLabel.text = balanceString
        }
    }
    
}

extension BudgetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.recentTransactions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
        
        if let currentUser = Auth.auth().currentUser?.email {
            db.collection(K.FireStore.transactionsCollection).order(by: K.FireStore.dateField, descending: true).getDocuments { querySnapshot, err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    let docs = querySnapshot!.documents
                    let data = docs[indexPath.row].data()
                    
                    let amountDouble = data[K.FireStore.transactionAmount] as! Double
                    
                    cell.transactionName.text = data[K.FireStore.transactionDescription] as! String
                    cell.transactionAmount.text = "\(amountDouble)"
            }
        }
    }
        
        return cell
    }
    
    
}
