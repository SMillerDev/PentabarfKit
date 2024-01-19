//
//  ImportHelper.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation
import SwiftyXMLParser

struct ImportHelper {
    fileprivate static let timezone: String = "01:00"

    static func filterElementByName(_ element: XML.Element, name: String) -> String? {
        return element.childElements.filter { $0.name == name }.first?.text
    }

    static func dateFromElementByName(_ element: XML.Element, name: String) -> Date? {
        guard let dateString = Self.filterElementByName(element, name: name) else {
            return nil
        }

        return try? Date("\(dateString)T00:00:00+\(Self.timezone)", strategy: .iso8601)
    }

    static func timeFromElementByName(_ element: XML.Element, name: String, date: Date) -> Date? {
        guard var timeString = Self.filterElementByName(element, name: name) else {
            return nil
        }
        if timeString.components(separatedBy: ":").count == 2 {
            timeString = "\(timeString):00"
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return try? Date("\(formatter.string(from: date))T\(timeString)+\(Self.timezone)", strategy: .iso8601)
    }

    static func intervalFromElementByName(_ element: XML.Element, name: String) -> TimeInterval? {
        let beginTime = try? Date("1970-01-01T00:00:00+\(Self.timezone)", strategy: .iso8601)
        guard let intervalTime = Self.timeFromElementByName(element, name: name, date: beginTime!) else {
            return nil
        }

        return intervalTime.distance(to: beginTime!)
    }
}

extension Conference {
    private static let errorMessage: String = "ERROR"

    static func from(_ element: XML.Element) -> Self {
        let title = ImportHelper.filterElementByName(element, name: "title") ?? Self.errorMessage
        let subtitle = ImportHelper.filterElementByName(element, name: "subtitle")
        let venue = ImportHelper.filterElementByName(element, name: "venue") ?? Self.errorMessage
        let city = ImportHelper.filterElementByName(element, name: "city") ?? Self.errorMessage
        let dayChange = ImportHelper.filterElementByName(element, name: "day_change") ?? Self.errorMessage

        let start = ImportHelper.dateFromElementByName(element, name: "start")!
        let end = ImportHelper.dateFromElementByName(element, name: "end")!

        let interval = ImportHelper.intervalFromElementByName(element, name: "timeslot_duration")
        return Self.init(
            title: title,
            subtitle: subtitle,
            venue: venue,
            city: city,
            start: start,
            end: end,
            dayChange: dayChange,
            timeslotDuration: interval!)
    }
}

extension Track {
    static func from(_ element: XML.Element) -> Self {
        var metadata: [String: String] = [:]

        element.attributes.forEach { attribute in
            metadata[attribute.key] = attribute.value
        }

        return Self.init(name: element.text!, metadata: metadata)
    }
}

extension ConferenceDay {
    static func from(_ element: XML.Element) -> Self {
        let index = Int(element.attributes["index"]!)!
        let dateText = element.attributes["date"]!
        let date = try? Date("\(dateText)T00:00:00+\(ImportHelper.timezone)", strategy: .iso8601)

        var rooms: [Room] = []
        element.childElements.forEach { roomElement in
            rooms.append(Room.from(roomElement, date: date!))
        }
        return Self.init(index: index, date: date!, rooms: rooms)
    }
}

extension Room {
    static func from(_ element: XML.Element, date: Date) -> Self {
        var events: [Event] = []
        element.childElements.forEach { eventElement in
            events.append(Event.from(eventElement, date: date))
        }
        return Self.init(name: element.attributes["name"]!, events: events)
    }
}

extension Event {
    private static let errorMessage: String = "ERROR"

    static func from(_ element: XML.Element, date: Date) -> Self {
        let language = ImportHelper.filterElementByName(element, name: "language") ?? "en"
        let locale = Locale(languageComponents: .init(identifier: language))
        var authors: [Person] = []
        element.childElements.filter { $0.name == "persons" }.first?.childElements.forEach { personElement in
            authors.append(Person.from(personElement))
        }
        var links: [Link] = []
        element.childElements.filter { $0.name == "links" }.first?.childElements.forEach { linkElement in
            guard let link = Link.from(linkElement) else {
                return
            }
            links.append(link)
        }
        var attachments: [Attachment] = []
        element.childElements.filter { $0.name == "attachments" }.first?.childElements.forEach { attachmentElement in
            attachments.append(Attachment.from(attachmentElement))
        }
        return Self.init(id: Int(element.attributes["id"]!)!,
                         start: ImportHelper.timeFromElementByName(element, name: "start", date: date)!,
                         duration: ImportHelper.intervalFromElementByName(element, name: "duration")!,
                         room: ImportHelper.filterElementByName(element, name: "room") ?? Self.errorMessage,
                         slug: ImportHelper.filterElementByName(element, name: "slug") ?? Self.errorMessage,
                         title: ImportHelper.filterElementByName(element, name: "title") ?? Self.errorMessage,
                         subtitle: ImportHelper.filterElementByName(element, name: "subtitle"),
                         track: ImportHelper.filterElementByName(element, name: "track") ?? Self.errorMessage,
                         type: ImportHelper.filterElementByName(element, name: "type") ?? Self.errorMessage,
                         language: locale,
                         abstract: ImportHelper.filterElementByName(element, name: "abstract") ?? Self.errorMessage,
                         description: ImportHelper.filterElementByName(element, name: "description") ?? "",
                         authors: authors,
                         attachments: attachments,
                         links: links)
    }
}

extension Person {
    static func from(_ element: XML.Element) -> Self {
        return Self.init(id: Int(element.attributes["id"]!)!, name: element.text!)
    }
}

extension Link {
    static func from(_ element: XML.Element) -> Self? {
        guard let urlText = element.attributes["href"], let url = URL(string: urlText) else {
            return nil
        }

        return Self.init(title: element.text ?? "Link", url: url)
    }
}

extension Attachment {
    static func from(_ element: XML.Element) -> Self {
        return Self.init(title: element.text ?? "Attachment",
                         url: URL(string: element.attributes["href"]!)!,
                         type: element.attributes["type"]!)
    }
}
