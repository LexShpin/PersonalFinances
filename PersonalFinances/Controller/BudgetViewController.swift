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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableViewCell)
        
        getBalance()
    }

    @IBAction func setBalancePressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Set your budget", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {[weak self, weak ac] action in
            if let answer = ac?.textFields?[0].text {
                self!.updateBalance(balance: answer)
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
    
    func updateBalance(balance: String?) {
        if let currentUser = Auth.auth().currentUser?.email, let currentBalance = balance {
            db.collection(K.FireStore.balanceCollection).document(currentUser).setData([
                K.FireStore.user: currentUser,
                K.FireStore.balanceField: currentBalance
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.getBalance()
                }
            }
        }
    }
    
    func getBalance() {
        if let currentUser = Auth.auth().currentUser?.email {
            db.collection(K.FireStore.balanceCollection).document(currentUser).getDocument(completion: { querySnapshot, err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    let data = querySnapshot?.data()
                    print(data)
                    self.totalBalanceLabel.text = data?[K.FireStore.balanceField] as? String
                }
            })
        }
    }
    
}

extension BudgetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.recentTransactions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell, for: indexPath) as! TransactionCell
        
        return cell
    }
    
    
}
