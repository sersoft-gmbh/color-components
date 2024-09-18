public import XCTest

extension XCTestCase {
    /// Throws `XCTSkip` with a message indicating that the API is not available on this platform.
    public func skipUnavailableAPI(file: StaticString = #filePath, line: UInt = #line) throws -> Never {
        throw XCTSkip("The tested API is not available on this platform.", file: file, line: line)
    }
}
