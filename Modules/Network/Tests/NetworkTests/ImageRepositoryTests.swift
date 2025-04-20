//
//  ImageRepositoryTests.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Testing
import UIKit
import NetworkTestHelpers

@testable import Network

@Suite("GIVEN a ImageRepository")
struct ImageRepositoryTests {
    var sut: ImageRepository
    let networkSpy: NetworkSpy

    init() async {
        networkSpy = NetworkSpy()
        sut = ImageRepository(network: networkSpy, cache: NSCache())
    }

    @Test(
    """
    WHEN fetch is called and data is not on the cache
    THEN it should execute de request and return a image successfully
    """
    )
    func testFetchFromRemoteSuccess() async throws {
        let image = try #require(UIImage(systemName: "chevron.right"))
        let url = try #require(URL(string: "https://www.example.com.br"))
        let imageData = try #require(image.pngData())

        await networkSpy.registerResponse(key: url, imageData)
        let result = await sut.fetch(from: url)

        #expect(result != nil)
        await #expect(networkSpy.methods == [.fetchData(url: url)])
    }

    @Test("""
    WHEN fetch is called and data is not on the cache
    THEN it should execute de request and it failed so it should return nil
    """
    )
    func testFetchFromRemoteFailed() async throws {
        let url = try #require(URL(string: "https://www.example.com.br"))

        let result = await sut.fetch(from: url)

        #expect(result == nil)
        await #expect(networkSpy.methods == [.fetchData(url: url)])
    }

    @Test("WHEN fetch is called and data is on the cache THEN it should return the cached image and not request again")
    mutating func testFetchFromCacheSuccess() async throws {
        let image = try #require(UIImage(systemName: "chevron.right"))
        let url = try #require(URL(string: "https://www.example.com.br"))
        let cache: NSCache<NSURL, UIImage> = NSCache()
        cache.setObject(image, forKey: url as NSURL)

        sut = ImageRepository(network: networkSpy, cache: cache)

        let result = await sut.fetch(from: url)

        #expect(result != nil)
        await #expect(networkSpy.methods.isEmpty)
    }

    @Test("WHEN a fetch is called twice THEN it should first return the execute only one fetch request")
    func testMultipleRequestForTheSameImage() async throws {
        let image = try #require(UIImage(systemName: "chevron.right"))
        let url = try #require(URL(string: "https://www.example.com.br"))
        let imageData = try #require(image.pngData())

        await networkSpy.registerResponse(key: url, imageData)
        let result = await sut.fetch(from: url)
        let secondResult = await sut.fetch(from: url)

        #expect(result != nil && secondResult != nil)
        await #expect(networkSpy.methods == [.fetchData(url: url)])
    }
}
