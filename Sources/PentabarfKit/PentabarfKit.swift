//
//  PentabarfKit.swift
//  
//
//  Created by Sean Molenaar on 07/01/2024.
//

import Foundation

public class PentabarfKit {
    public static func loadConference(_ url: URL) async throws -> Conference? {
        print("📲 Getting schedule: \(url)")
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print("📲 Got schedule: \(url)")

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("❌ Failed to fetch schedule")
            return nil
        }

        guard let event = DataParser.parse(data) else {
            print("❌ Failed to parse schedule")
            return nil
        }

        return event
    }
}
