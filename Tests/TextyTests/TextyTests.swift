import XCTest
@testable import Texty

final class TextyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Texty().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
