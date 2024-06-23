//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct Track {
    public let name: String
    public let metadata: [String: Any] = [:]
}

extension Track: Hashable {
    public static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
