//
//  SeatsTableViewCell.swift
//  LoginxCasa
//
//  Created by Jason Bourne on 01/11/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

class SeatsTableViewCell: UITableViewCell {

    @IBOutlet weak var immagine: UIImageView!
    
    @IBOutlet weak var nome: UILabel!
        
    @IBOutlet weak var cognome: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
