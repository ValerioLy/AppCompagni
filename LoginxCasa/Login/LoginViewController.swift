//
//  LoginViewController.swift
//  Cinema
//
//  Created by Jason Bourne on 16/10/18.
//  Copyright © 2018 Michele Pertile. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var listOfPerson : [Persona] = []
    
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        for variabile in listOfPerson {
            if variabile.email == emailOutlet.text && variabile.password == passwordOutlet.text{
                NSLog("Login corretto" )
                
                self.performSegue(withIdentifier: "segueListaCompagni", sender: self)
                
            }
            else{
                
            }
            NSLog("Login errato")
            let alert = UIAlertController(title: "Login failed", message: "wrong password or email", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func registerAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueRegister", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfPerson = Persona.all()
        
    }
    
    
    
    
    
    
    
    
}




