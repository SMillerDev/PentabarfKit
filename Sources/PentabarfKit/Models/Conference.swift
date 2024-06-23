//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct Conference {
    public let title: String
    public let subtitle: String?

    public let venue: String
    public let city: String

    public let start: Date
    public let end: Date

    public let dayChange: String
    public let timeslotDuration: TimeInterval

    public var days: [ConferenceDay] = []

    public lazy var events: [Event] = {
        days.flatMap { dayL in
            var day = dayL
            return day.events
        }
    }()

    public lazy var rooms: [Room] = {
        Array(Set(days.flatMap { dayL in
            var day = dayL
            return day.rooms
        }))
    }()

    public lazy var tracks: [Track] = {
        Array(Set(events.map { event -> Track in
            return event.track
        }))
    }()

    public lazy var authors: [Person] = {
        Array(Set(events.flatMap { event -> [Person] in
            return event.authors
        }))
    }()
}
