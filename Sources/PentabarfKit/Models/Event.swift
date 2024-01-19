//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct Event {
    public let id: Int
    public let start: Date
    public let duration: TimeInterval
    public let room: String
    public let slug: String
    public let title: String
    public let subtitle: String?
    public let track: String
    public let type: String
    public let language: Locale
    public let abstract: String
    public let description: String
    public let authors: [Person]
    public let attachments: [Attachment]
    public let links: [Link]
}
