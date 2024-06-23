//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct Person {
    public let id: Int
    public let name: String
}

extension Person: Hashable {
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
