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
        DIMocks.register()
    }

    @Test("WHEN view is called with a HomeRoute THEN it should return a ViewController")
    func testHomeRoute() async throws {
        let result = try #require(sut.view(for: HomeRoute()))
        #expect(result != nil)
    }

    @Test("WHEN view is called with a PullRequest THEN it should return a ViewController")
    func testPullRequestRoute() async throws {
        let result = try #require(sut.view(for: PullRequestRoute(path: "")))
        #expect(result != nil)
    }

    @Test("WHEN view is called with a WebRoute THEN it should return a ViewController")
    func testWebViewRequestRoute() async throws {
        let result = try #require(sut.view(for: WebRoute(path: "")))
        #expect(result != nil)
    }

    @Test("WHEN view is called with a unknown route THEN it should return nil")
    func testUnknownRoute() async throws {
        let result = sut.view(for: UnknownRoute())
        #expect(result == nil)
    }
}
