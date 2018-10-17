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
    
    
    
    
//    private let pets : List<Pet> = List<Pet>()
    
    
    convenience init(name : String? = nil, surname: String? = nil, mobile: String? = nil, image: Data? = nil) {
        self.init()
        
        self.name = name
        self.surname = surname
        self.mobile = mobile
        
        self.image = image
        
        self.id = UUID().uuidString
        
        
    }
    
   
    
    
    
    
    func changeData(in realm: Realm = try! Realm(configuration: RealmUtils.config), name : String? = nil, surname: String? = nil, mobile: String? = nil, image: Data? = nil, person: Person? = nil) {
        do {
            try realm.write {
                
                self.name = name ?? person?.name ?? self.name
                self.surname = surname ?? person?.surname ?? self.surname
                self.mobile = mobile ?? person?.mobile ?? self.mobile
                
                self.image = image ?? person?.image ?? self.image
                
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
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Person] {
        return Array(realm.objects(Person.self))
    }
    
    
}
