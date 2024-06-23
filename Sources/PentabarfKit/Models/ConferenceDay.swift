//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct ConferenceDay {
    public let index: Int
    public let date: Date
    public let rooms: [Room]

    public lazy var events: [Event] = {
        return rooms.flatMap { room -> [Event] in
            return room.events
        }
    }()
}
