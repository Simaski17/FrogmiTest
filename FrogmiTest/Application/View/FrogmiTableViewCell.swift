//
//  FrogmiTableViewCell.swift
//  FrogmiTest
//
//  Created by Jimmy Hernandez on 23-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import UIKit

class FrogmiTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idStoreLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(event: [Store], index: IndexPath) {
        self.nameLabel.text = event[index.row].name
        self.idStoreLabel.text = event[index.row].storeCode
        self.addressLabel.text = event[index.row].address

    }

}
