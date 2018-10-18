//
//  RegisterViewController.swift
//  Cinema
//
//  Created by Giacomo on 16/10/18.
//  Copyright © 2018 Michele Pertile. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    enum TextFieldsType : Int{
        case name = 0
        case surname
        case email
        case password
        case password2
    }
    private var listPerson : [Persona]!
    
    @IBOutlet var registerCollection: [UITextField]!
    @IBAction func registerActionButton(_ sender: UIButton) {
        for tag in 0...4 {
            NSLog("tag: "+String(tag))
            guard registerCollection[tag].text != "" else{
                myAlert("Empty fields")
                NSLog("campi vuoti")
                return
            }
        }
        NSLog("campi non vuoti")
        var pw : String!
        pw = registerCollection[TextFieldsType.password.rawValue].text
        guard pw == registerCollection[TextFieldsType.password2.rawValue].text else{
            myAlert("Different emails")
            NSLog("password diverse")
            return
        }
        NSLog("password uguali")
        guard pw.count > 5 else{
            myAlert("Password must have almost 6 characters")
            NSLog("password minore di 6 car")
            return
        }
        NSLog("password.count OK!")
        let email : String! = registerCollection[TextFieldsType.email.rawValue].text
        for persona in listPerson {
            guard persona.email != email else{
                myAlert("Existing email")
                NSLog("email già esistente")
                return
            }
            
        }
        guard isValidEmail(testStr: email) else{
            myAlert("Invalid email")
            NSLog("Email non valida!")
            return
        }
        NSLog("email non esistente")
        Persona(name: registerCollection[TextFieldsType.name.rawValue].text, surname: registerCollection[TextFieldsType.surname.rawValue].text, password: registerCollection[TextFieldsType.password.rawValue].text, email: registerCollection[TextFieldsType.email.rawValue].text).add()
        NSLog("Salvato, registrato!")
        
        self.performSegue(withIdentifier: "segueLogin", sender: self.dismiss)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        listPerson = Persona.all()
        
        
    }
    
    
    @IBAction func GoUserProfile(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segueUserProfile", sender: self.dismiss)
    }
    
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func myAlert(_ text : String!){
        let alert = UIAlertController(title: "Attention", message: text, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
