//
//  Friend.swift
//  FriendFace
//
//  Created by Guru Ranganathan on 8/30/20.
//  Copyright © 2020 Guru. All rights reserved.
//

import Foundation

struct Friend: Codable {
    
    var id : UUID
    var name: String
    var age: Int
    var address: String
    var company: String
    var friends: [Connection]
    
}
