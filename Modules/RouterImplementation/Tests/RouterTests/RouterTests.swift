import Testing
import Foundation
import RouterInterface
@testable import RouterImplementation

@MainActor
@Suite("GIVEN a Router")
struct RouterTests {
    let sut: Router

    init() {
        sut = Router()
    }

    @Test("WHEN view is called with a HomeRoute THEN it should return a HomeViewController")
    func testHomeRoute() async throws {
        let result = try #require(sut.view(for: HomeRoute()))
        #expect(Expectation.isInstanceOf("HomeViewController", object: result))
    }

    @Test("WHEN view is called with a unknown route THEN it should return nil")
    func testUnknownRoute() async throws {
        let result = sut.view(for: UnknownRoute())
        #expect(result == nil)
    }
}
