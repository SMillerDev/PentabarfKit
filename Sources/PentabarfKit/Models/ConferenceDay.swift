//
//  Models.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public struct ConferenceDay {
    static let elementname: String = "day"

    public let index: Int
    public let date: Date
    public let rooms: [Room]

}
