import XCTest
@testable import CountryManager

final class CountryManagerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CountryManager().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
