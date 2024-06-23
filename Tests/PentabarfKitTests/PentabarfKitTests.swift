import XCTest
@testable import PentabarfKit

final class PentabarfKitTests: XCTestCase {
    func test2019() async throws {
        let path = Bundle.module.path(forResource: "schedule_2019", ofType: "xml")
        var event = try await PentabarfLoader.fetchConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(event)
        XCTAssertEqual(event?.city, "Brussels")
        XCTAssertEqual(event?.days.count, 2)
        XCTAssertEqual(event?.tracks.count, 62)
        XCTAssertEqual(event?.events.count, 775)
        XCTAssertEqual(event?.rooms.count, 34)
        XCTAssertEqual(event?.authors.count, 730)
    }

    func test2019Details() async throws {
        let path = Bundle.module.path(forResource: "schedule_2019", ofType: "xml")
        var conference = try await PentabarfLoader.fetchConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(conference)

        let event = conference?.events.first { !$0.links.isEmpty }
        XCTAssertNotNil(event)

        XCTAssertFalse(event!.abstract.isEmpty)
        XCTAssertNotNil(event?.language)
        XCTAssertFalse(event!.duration <= 0)

        let author = event?.authors.first
        XCTAssertNotNil(author?.name)

        let link = event?.links.first
        XCTAssertEqual(link?.title, "Video recording (WebM/VP9)")
        XCTAssertEqual(link?.url.absoluteString, "https://video.fosdem.org/2019/Janson/keynotes_welcome.webm")
    }

    func test2022Virtual() async throws {
        let path = Bundle.module.path(forResource: "schedule_2022", ofType: "xml")
        var event = try await PentabarfLoader.fetchConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(event)
        XCTAssertEqual(event?.city, "Brussels")
        XCTAssertEqual(event?.days.count, 2)
        XCTAssertEqual(event?.tracks.count, 100)
        XCTAssertEqual(event?.events.count, 730)
        XCTAssertEqual(event?.rooms.count, 102)
        XCTAssertEqual(event?.authors.count, 655)
    }

    func test2022Details() async throws {
        let path = Bundle.module.path(forResource: "schedule_2022", ofType: "xml")
        var conference = try await PentabarfLoader.fetchConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(conference)

        let event = conference?.events.first { !$0.attachments.isEmpty }
        XCTAssertNotNil(event)

        let attachment = event!.attachments.first
        // swiftlint:disable:next line_length
        XCTAssertEqual(attachment?.title, "Making a community-managed FOSS project sustainable in the medium- to long-term")
        // swiftlint:disable:next line_length
        XCTAssertEqual(attachment?.url.absoluteString, "https://fosdem.org/2022/schedule/event/community_sustainable/attachments/audio/5230/export/events/attachments/community_sustainable/audio/5230/makingacommunitymanagedfossprojectsustainable.pdf")
        XCTAssertEqual(attachment?.type, "audio")
    }

    func test2023() async throws {
        let path = Bundle.module.path(forResource: "schedule_2023", ofType: "xml")
        var event = try await PentabarfLoader.fetchConference(URL(fileURLWithPath: path!))

        XCTAssertNotNil(event)
        XCTAssertEqual(event?.city, "Brussels")
        XCTAssertEqual(event?.days.count, 2)
        XCTAssertEqual(event?.tracks.count, 0)
        XCTAssertEqual(event?.events.count, 0)
        XCTAssertEqual(event?.rooms.count, 25)
        XCTAssertEqual(event?.authors.count, 0)
    }
}
