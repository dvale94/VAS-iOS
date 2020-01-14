import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GCI_iOSTests.allTests),
    ]
}
#endif
