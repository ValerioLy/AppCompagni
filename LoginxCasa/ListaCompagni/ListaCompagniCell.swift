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
    
    @IBOutlet var stars: [UIButton]!
    
    
    static let kidentifier = "ListaCompagniCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }
    

    @IBAction func ActionStars(_ sender: UIButton) {
        
        for btn in stars {
            if(btn.tag <= sender.tag){
                btn.setTitle("★", for: .normal)
            }
            else {
                btn.setTitle("☆", for: .normal)
            }
        }
    }
    
   
    
}
