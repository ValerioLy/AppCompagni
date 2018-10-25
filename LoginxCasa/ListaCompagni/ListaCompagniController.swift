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
    func editCompagno(compagno : Compagno, name : String, surname : String, image : Data, star1 : String, star2 : String, star3 : String, star4 : String, star5 : String)
    
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


        if let stella1 = listaCompagni[indexPath.row].star1{
            cell.stars[0].setTitle(stella1, for: .normal)
        }
        
        if let stella2 = listaCompagni[indexPath.row].star2{
            cell.stars[1].setTitle(stella2, for: .normal)
        }
        
        if let stella3 = listaCompagni[indexPath.row].star3{
            cell.stars[2].setTitle(stella3, for: .normal)
        }
        
        if let stella4 = listaCompagni[indexPath.row].star4{
            cell.stars[3].setTitle(stella4, for: .normal)
        }
        
        if let stella5 = listaCompagni[indexPath.row].star5{
            cell.stars[4].setTitle(stella5, for: .normal)
        }
       
        
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            

            listaCompagni[indexPath.row].remove()
            listaCompagni.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
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
        let Nome = UIAlertAction(title: "Nome", style: .default) { action in
            self.listaCompagni=self.listaCompagni.sorted(by: { $0.getName() < $1.getName() })
            self.tableView.reloadData()
        }
        alert.addAction(Nome)
        
        let Cognome = UIAlertAction(title: "Cognome", style: .default){ action in
            self.listaCompagni=self.listaCompagni.sorted(by: { $0.getSurname() < $1.getSurname() })
            self.tableView.reloadData()
        }
        alert.addAction(Cognome)
       
        let Stelle = UIAlertAction(title: "Stelle", style: .default) { action in
            self.listaCompagni=self.listaCompagni.sorted(by: { $0.getStars() < $1.getStars() })
            self.tableView.reloadData()
        }
      
        
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
    
    func editCompagno(compagno : Compagno, name : String, surname : String, image : Data, star1 : String, star2 : String, star3 : String, star4 : String, star5 : String) {
        compagno.changeData(name: name,surname: surname,image: image, star1 : star1, star2 : star2, star3 : star3, star4 : star4, star5 : star5)
        
        tableView.reloadData()
        
    }
    
}
