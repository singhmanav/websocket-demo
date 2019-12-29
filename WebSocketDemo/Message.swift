//
//  Message.swift
//  WebSocketDemo
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import Foundation

struct Message {
    var type:MessageType
    var value:String
}

enum MessageType{
    case incoming
    case outgoing
}
