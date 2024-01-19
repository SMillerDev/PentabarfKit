//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

struct Conference {
    static let elementname: String = "conference"

    let title: String
    let subtitle: String?

    let venue: String
    let city: String

    let start: Date
    let end: Date

    let dayChange: String
    let timeslotDuration: TimeInterval

    var tracks: [Track] = []
    var days: [ConferenceDay] = []
}

struct Track {
    static let elementname: String = "tracks"

    let name: String
    let metadata: [String: Any]
}

struct ConferenceDay {
    static let elementname: String = "day"

    let index: Int
    let date: Date
    let rooms: [Room]

}

struct Room {
    let name: String
    let events: [Event]
}

struct Event {
    let id: Int
    let start: Date
    let duration: TimeInterval
    let room: String
    let slug: String
    let title: String
    let subtitle: String?
    let track: String
    let type: String
    let language: Locale
    let abstract: String
    let description: String
    let authors: [Person]
    let attachments: [Attachment]
    let links: [Link]
}

struct Person {
    let id: Int
    let name: String
}

struct Attachment {
    let title: String
    let url: URL
    let type: String
}

struct Link {
    let title: String
    let url: URL
}
