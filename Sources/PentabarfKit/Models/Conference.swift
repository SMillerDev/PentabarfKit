//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct Conference {
    static let elementname: String = "conference"

    public let title: String
    public let subtitle: String?

    public let venue: String
    public let city: String

    public let start: Date
    public let end: Date

    public let dayChange: String
    public let timeslotDuration: TimeInterval

    public var tracks: [Track] = []
    public var days: [ConferenceDay] = []
}
