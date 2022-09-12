//
//  TransactionCell.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 12.09.2022.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet var transactionName: UILabel!
    @IBOutlet var transactionAmount: UILabel!
    @IBOutlet var categoryChoiceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setPopUpButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPopUpButton() {
        
        let optionClosure = { (action: UIAction) in
            self.categoryChoiceButton.setImage(action.image, for: .normal)
        }
        
        categoryChoiceButton.menu = UIMenu(children: [
            UIAction(title: "Groceries", image: UIImage(named: "groceries_icon"), state: .off, handler: optionClosure),
            UIAction(title: "Medicine", image: UIImage(named: "medicine_icon"), state: .off, handler: optionClosure),
            UIAction(title: "Travel", image: UIImage(named: "travel_icon"), state: .off, handler: optionClosure),
            UIAction(title: "Rent", image: UIImage(named: "rent_icon"), state: .off, handler: optionClosure),
        ])
    }
    
}
