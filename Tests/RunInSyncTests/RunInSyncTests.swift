import XCTest
@testable import RunInSync

final class RunInSyncTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        Task {
            do {
                try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
                print("2")
            } catch {
                print(error)
            }
        }
        
        RunInSync {
            do {
                try await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
                print("1")
            } catch {
                print(error)
            }
        }
        
        print("3")
    }
}
