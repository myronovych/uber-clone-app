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
let DRIVER_LOC_REF = DB_REF.child("drivers-location")

struct Service {
    static let shared = Service()
    
    private init() {}
    
    func fetchUserData(completion: @escaping (User) -> Void) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        print("DEBUG: current user \(currentUID)")
        
        USR_REF.child(currentUID).observeSingleEvent(of: .value) { (snap) in
            guard let dictionary = snap.value as? [String: Any] else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
