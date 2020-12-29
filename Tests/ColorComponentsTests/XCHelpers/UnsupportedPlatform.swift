import XCTest

extension XCTestCase {
    func skipUnavailableAPI(file: StaticString = #file, line: UInt = #line) throws -> Never {
        throw XCTSkip("The tested API is not available on this platform.", file: file, line: line)
    }
}
