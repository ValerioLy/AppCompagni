//
//  ListaCompagniCell.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 17/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

class ListaCompagniCell: UITableViewCell {

    
    @IBOutlet weak var Img: UIButton!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var SurnameLabel: UILabel!
    
    @IBOutlet  var stairs: [UIButton]!
    
    static let kidentifier = "ListaCompagniCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }
    
    
    @IBAction func ActionStairs(_ sender: UIButton) {
        
      
    }
    
  
   
    
}
