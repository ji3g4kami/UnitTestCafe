//
//  FirebaseManager.swift
//  UnitTestCafe
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import Firebase
import FirebaseDatabase
import CodableFirebase

class FirebaseManager {
    static let shared = FirebaseManager()
    lazy var ref = Database.database().reference()
    
    func queryMenu(completion: @escaping ([Item]) -> Void) {
        var itemArray = [Item]()
        let dispatchGroup = DispatchGroup()
        ref.child("items").observe(.value) { (snapshot) in
            dispatchGroup.enter()
            for child in snapshot.children {
                if let childDict = child as? DataSnapshot, let childValue = childDict.value {
                    do {
                        let item = try FirebaseDecoder().decode(Item.self, from: childValue)
                        itemArray.append(item)
                    } catch {
                        print(error)
                    }
                }
            }
            dispatchGroup.leave()
            dispatchGroup.notify(queue: .main) {
                completion(itemArray)
            }
        }
    }
}
