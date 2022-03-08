//
//  CryptoTableViewCell.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 07.03.2022.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    static let reuseId = "cell"
    
    private let cryptoTextLabelCell = UILabel()
    private let cryptoDetailTextLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cryptoTextLabelCell.translatesAutoresizingMaskIntoConstraints = false
        cryptoDetailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cryptoTextLabelCell)
        contentView.addSubview(cryptoDetailTextLabel)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
