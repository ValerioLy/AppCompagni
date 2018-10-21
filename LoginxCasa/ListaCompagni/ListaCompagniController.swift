//
//  ViewController.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 17/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

// delegate aggiungi compagno
protocol CompagnoDelegate: class {
    func addingCompagno(compagno: Compagno)
    
}


class ListaCompagniController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
   
    var person : Persona = Persona()
    
    
    private var listaCompagni : [Compagno] = []  
    
    private var selectedCompagno : Compagno?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        listaCompagni = Compagno.all()

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCompagni.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListaCompagniCell.kidentifier, for: indexPath) as! ListaCompagniCell


        cell.NameLabel.text = listaCompagni[indexPath.row].name
        cell.SurnameLabel.text = listaCompagni[indexPath.row].surname

        
        if let imageProfile = listaCompagni[indexPath.row].image{
          cell.Img.setImage(UIImage(data: imageProfile), for: .normal)
        } else {
            cell.Img.setImage(UIImage(named: "place"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            person.removeCompagno(index: indexPath.row)
            listaCompagni[indexPath.row].remove()
            listaCompagni.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let DvC = Storyboard.instantiateViewController(withIdentifier: "CompagnoProfileController") as! CompagnoProfileController
//        DvC.nameShow = listaCompagni[indexPath.row]
//        DvC.surnameShow = listaCompagni[indexPath.row]
//        DvC.imageShow = listaCompagni[indexPath.row]
        
        selectedCompagno = listaCompagni[indexPath.row]
        self.performSegue(withIdentifier: "segueCompagnoProfile", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "segueCompagnoProfile":
            if let destinationController = segue.destination as? CompagnoProfileController {
                destinationController.compagno = selectedCompagno ?? Compagno()
                destinationController.delegate = self
            }
        default:
            break
        }
        
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
    
    
   
    
    @IBAction func GoProfile(_ sender: UIBarButtonItem) {
         selectedCompagno = nil
         self.performSegue(withIdentifier: "segueCompagnoProfile", sender: self)
    }
    
    
    
    @IBAction func GoSeats(_ sender: Any) {
         self.performSegue(withIdentifier: "segueSeats", sender: self)
    }
    
}

extension ListaCompagniController: CompagnoDelegate {
    
   //
    func addingCompagno(compagno: Compagno) {
        compagno.add()
        person.addingCompagni(compagno: compagno)
        listaCompagni.append(compagno)
        tableView.insertRows(at: [IndexPath(item: listaCompagni.count - 1, section: 0)], with: .automatic)
        tableView.reloadData()
    }
    

    
}
