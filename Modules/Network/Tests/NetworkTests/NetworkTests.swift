import Testing
import Foundation
@testable import Network

@Suite("GIVEN a Network")
struct NetworkTests {
    let sut: Network
    let sessionSpy: URLSessionSpy

    init() {
        sessionSpy = URLSessionSpy()
        sut = Network(session: sessionSpy)
    }

    @Test("WHEN fetch url is called THEN it should return the decoded data")
    func testFetchUrl() async throws {
        let data = try #require(DecodableMock.json)
        let url = try #require(URL(string: "https://www.example.com.br"))

        await sessionSpy.registerResponse(key: url, data)

        let (result, _): (DecodableMock, URLResponse) = try await sut.fetch(from: url)

        #expect(result == .mock)
        await #expect(sessionSpy.methods == [.dataUrl(url: url)])
    }

    @Test("WHEN fetch request is called THEN it should return the decoded data")
    func testFetchRequest() async throws {
        let data = try #require(DecodableMock.json)
        let url = try #require(URL(string: "https://www.example.com.br"))
        let request = URLRequest(url: url)

        await sessionSpy.registerResponse(key: url, data)

        let (result, _): (DecodableMock, URLResponse) = try await sut.fetch(from: request)

        #expect(result == .mock)
        await #expect(sessionSpy.methods == [.dataRequest(request: request)])
    }

    @Test("WHEN fetch data is called THEN it should return the data")
    func testFetchData() async throws {
        let data = try #require(DecodableMock.json)
        let url = try #require(URL(string: "https://www.example.com.br"))

        await sessionSpy.registerResponse(key: url, data)

        let response = try await sut.fetch(from: url)

        #expect(response == data)
        await #expect(sessionSpy.methods == [.dataUrl(url: url)])
    }
}
