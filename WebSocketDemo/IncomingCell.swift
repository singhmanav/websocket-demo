//
//  IncomingCell.swift
//  WebSocketDemo
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import UIKit

class IncomingCell: UITableViewCell {

    @IBOutlet weak var label: PaddingLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(){
        self.label.layer.cornerRadius = 6.0
        self.label?.layer.masksToBounds = true
    }

}
