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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
