import XCTest
@testable import PentabarfKit

final class PentabarfKitTests: XCTestCase {
    func test2019() async throws {
        let path = Bundle.module.path(forResource: "schedule_2019", ofType: "xml")
        let event = try await PentabarfKit.loadConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(event)
        XCTAssertEqual(event?.city, "Brussels")
    }

    func test2022Virtual() async throws {
        let path = Bundle.module.path(forResource: "schedule_2022", ofType: "xml")
        let event = try await PentabarfKit.loadConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(event)
        XCTAssertEqual(event?.city, "Brussels")
    }


    func test2023() async throws {
        let path = Bundle.module.path(forResource: "schedule_2023", ofType: "xml")
        let event = try await PentabarfKit.loadConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(event)
        XCTAssertEqual(event?.city, "Brussels")
    }
}
