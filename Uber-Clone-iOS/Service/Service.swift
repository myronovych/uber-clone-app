//
//  Service.swift
//  Uber-Clone-iOS
//
//  Created by rs on 17.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation
import Firebase

let DB_REF = Database.database().reference()
let USR_REF = DB_REF.child("users")

struct Service {
    static let shared = Service()
    let currentUID = Auth.auth().currentUser?.uid
    
    private init() {}
    
    func fetchUserData() {
        print("DEBUG: current user \(currentUID!)")
        USR_REF.child(currentUID!).observeSingleEvent(of: .value) { (snap) in
            guard let dictionary = snap.value as? [String: Any] else { return }
            guard let fullName = dictionary["fullName"] as? String else { return }
            print ("DEBUG: FULL NAME \(fullName)")
        }
    }
}
