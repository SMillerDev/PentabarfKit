//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct Room {
    public let name: String
    public let events: [Event]
}

extension Room: Hashable {
    public static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
