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
    
    
    @IBOutlet weak var emailTesto: UILabel! {
    didSet {
    emailTesto.text = "kLoginEmailLabel".localized
    }
}
    
    @IBOutlet weak var passwordTesto: UILabel!
        {
        didSet {
            passwordTesto.text = "kLoginPasswordLabel".localized
        }
    }
    
    @IBOutlet weak var LoginOutlet: UIButton!
        {
        didSet {
            LoginOutlet.setTitle("kLoginButton".localized, for: .normal)
        }
    }
    @IBOutlet weak var RegisterOutlet: UIButton!
        {
        didSet {
            RegisterOutlet.setTitle("kRegisterButton".localized, for: .normal)
        }
    }
    
    
    @IBOutlet weak var emailOutlet: UITextField! {
        didSet {
            emailOutlet.placeholder = "kLoginEmailPlaceHolder".localized
        }
    }
    @IBOutlet weak var passwordOutlet: UITextField!{
        didSet {
           passwordOutlet.placeholder = "kLoginPasswordPlaceHolder".localized
        }
    }
    
    private var user : Persona!

    
    @IBAction func loginAction(_ sender: UIButton) {
        
        
        
//        for variabile in listOfPerson {
//            NSLog(variabile.email! + " " + variabile.password)
//        }
        
        
        
        for variabile in listOfPerson {
            if variabile.email == emailOutlet.text && variabile.password == passwordOutlet.text{
                NSLog("Login corretto" )
                user = variabile
                self.performSegue(withIdentifier: "segueListaCompagni", sender: self)
                break
            }
          
            
        }
        NSLog("Login errato")
        let alert = UIAlertController(title: "Login failed", message: "wrong password or email", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func registerAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueRegister", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfPerson = Persona.all()
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "segueListaCompagni":
            if let destinationController = segue.destination as? ListaCompagniController {
                destinationController.person = user ?? Persona()
            }
        default:
            break
            
        }
    }
    
   
    
    
}




