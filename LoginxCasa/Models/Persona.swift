//
//  Persona.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 17/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit
import RealmSwift
@objcMembers class Persona: Object {

    dynamic var id : String!
    dynamic var image : Data?
    dynamic var name : String?
    dynamic var surname : String?
    dynamic var mobile : String?
    dynamic var email : String?
    dynamic var password : String!
    
    private let compagni : List<Compagno> = List<Compagno>()
    
    

    convenience init(image: Data? = nil, name : String? = nil, surname: String? = nil, password: String? = nil, mobile: String? = nil, email : String? = nil) {
        self.init()
        
        self.id = UUID().uuidString
        self.image = image
        self.name = name
        self.surname = surname
        self.mobile = mobile
        self.email = email
        self.password = password


    }

    
    func getCompagni() -> [Compagno] {
        return Array(compagni)
    }

    
   override static func primaryKey() -> String? {
        return "id"
    }
    
    func changeData(in realm: Realm = try! Realm(configuration: RealmUtils.config), name : String? = nil, surname: String? = nil, mobile: String? = nil, password: String? = nil, image: Data? = nil, email: String? = nil, persona: Persona? = nil) {
        do {
            try realm.write {
                
                self.image = image ?? persona?.image ?? self.image
                self.name = name ?? persona?.name ?? self.name
                self.surname = surname ?? persona?.surname ?? self.surname
                self.mobile = mobile ?? persona?.mobile ?? self.mobile
                self.email = email ?? persona?.email ?? self.email
                self.password = password ?? persona?.password ?? self.password
            }
        }catch {}

    }


    func add(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {}
    }

    // withid è l'email
    static func readUser(in realm: Realm = try! Realm(configuration: RealmUtils.config), withid: String) -> Persona? {
        return realm.object(ofType: Persona.self, forPrimaryKey: withid)
}
    
    
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Persona] {
        return Array(realm.objects(Persona.self))
    }
}