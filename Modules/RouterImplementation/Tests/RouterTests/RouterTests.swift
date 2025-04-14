import Testing
import Foundation
import RouterInterface
import Model
@testable import Router

@MainActor
@Suite("GIVEN a Router")
struct RouterTests {
    let sut: Router
    
    init() {
        sut = Router()
        RouterProvider.shared.router = sut
    }
    
    @Test("WHEN view is called with a HomeRoute THEN it should return a HomeViewController")
    func testHomeRoute() async throws {
        let result = try #require(sut.view(for: HomeRoute()))
        #expect(Expectation.isInstanceOf("HomeViewController", object: result))
    }
    
    @Test("WHEN view is called with a SeachRoute THEN it should return a SearchViewController")
    func testSearchRoute() async throws {
        let result = try #require(sut.view(for: SearchRoute(query: "query")))
        #expect(Expectation.isInstanceOf("SearchViewController", object: result))
    }
    
    @Test("WHEN view is called with a DetailRoute THEN it should return a DetailViewController")
    func testDetailRoute() async throws {
        let url = try #require(URL(string: "https://www.example.com.br"))
        let detail = ProductDetail(
            id: "",
            title: "",
            condition: "",
            thumbnail: url,
            thumbnailId: "",
            currencyId: "",
            price: 0,
            originalPrice: nil,
            availableQuantity: 0,
            officialStoreName: nil,
            acceptsMercadopago: false,
            shipping: .init(freeShipping: true),
            attributes: []
        )
        
        let result = try #require(sut.view(for: DetailRoute(detail: detail)))
        #expect(Expectation.isInstanceOf("DetailViewController", object: result))
    }
    
    @Test("WHEN view is called with a unknown route THEN it should return nil")
    func testUnknownRoute() async throws {
        let result = sut.view(for: UnknownRoute())
        #expect(result == nil)
    }
}
