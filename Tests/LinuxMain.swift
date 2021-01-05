import XCTest

import ColorCalculationsTests
import ColorComponentsTests

var tests = [XCTestCaseEntry]()
tests += ColorCalculationsTests.__allTests()
tests += ColorComponentsTests.__allTests()

XCTMain(tests)
