import XCTest
import SwiftUI
@testable import BottomSheet

final class BottomSheetTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BottomSheet(isOpen: .constant(true)){ Text("Test") }.openLocation, .middle)
    }
}
