//
//  ViewController.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 17/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

class ListaCompagniController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListaCompagniCell.kidentifier, for: indexPath) as! ListaCompagniCell
        
        return cell
    }
    
}

