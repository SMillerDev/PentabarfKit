//
//  DataParser.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation
import SwiftyXMLParser

struct DataParser {
    static func parse(_ data: Data) -> Conference? {
        let data = XML.parse(data)
        var conference: Conference?

        data.element?.childElements.first?.childElements.forEach { element in
            switch element.name {
            case Conference.elementname:
                conference = Conference.from(element)
            case Track.elementname:
                element.childElements.forEach { trackElement in
                    conference?.tracks.append(Track.from(trackElement))
                }
            case ConferenceDay.elementname:
                conference?.days.append(ConferenceDay.from(element))
            default:
                break
            }
        }

        return conference
    }
}
