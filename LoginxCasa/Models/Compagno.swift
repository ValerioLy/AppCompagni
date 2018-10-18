//
//  Compagni.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 17/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Compagno: Object {
    
     dynamic var id : String!
    dynamic var image : Data?
    dynamic var name : String?
    dynamic var surname : String?

    
    convenience init(name : String? = nil, surname: String? = nil, image: Data? = nil) {
        self.init()
        
        
        self.id = UUID().uuidString
        self.name = name
        self.surname = surname
        self.image = image
        
        
    }
    
    func add(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {}
    }
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Compagno] {
        return Array(realm.objects(Compagno.self))
    }

    override static func primaryKey() -> String? {
        return "id"
    }
    static func readUser(in realm: Realm = try! Realm(configuration: RealmUtils.config), withid: String) -> Persona? {
        return realm.object(ofType: Persona.self, forPrimaryKey: withid)
    }
    
}
