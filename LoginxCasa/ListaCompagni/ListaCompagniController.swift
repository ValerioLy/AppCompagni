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
    
    var listaCompagni : [Compagno] = Compagno.all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listaCompagni.count == 0 {
        for i in 1...30 {
            listaCompagni.append(Compagno(name : "Nome+\(i)", surname: "cognome", image: UIImage(named: "place")?.pngData()))
        }
    }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCompagni.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListaCompagniCell.kidentifier, for: indexPath) as! ListaCompagniCell
              cell.NameLabel[0].text = listaCompagni[indexPath.row].name
              cell.SurnameLabel[0].text = listaCompagni[indexPath.row].surname
              
        return cell
    }
    
    
    @IBAction func ActionFilter(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Filtra", message: "Vuoi Filtrare?", preferredStyle: .alert)
        let Nome = UIAlertAction(title: "Nome", style: .default, handler: nil)
        alert.addAction(Nome)
        
        let Cognome = UIAlertAction(title: "Cognome", style: .default, handler: nil)
        alert.addAction(Cognome)
        
        let Stelle = UIAlertAction(title: "Nome", style: .default, handler: nil)
        alert.addAction(Stelle)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func goCompagniProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "segueCompagnoProfile", sender: self)
    }
    
    
    @IBAction func GoSeats(_ sender: Any) {
         self.performSegue(withIdentifier: "segueSeats", sender: self)
    }
    
}

