//
//  HomeFactoryTests.swift
//  Home
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import Network
import NetworkTestHelpers
import RouterInterface
import RouterInterfaceTestHelpers
import Testing

@testable import DependencyInjection
@testable import HomeImplementation

@MainActor
@Suite("GIVEN a Home Factory without DI registration")
struct HomeFactoryTestsWithoutDI {
    @Test("WHEN build is called THEN it should return nil")
    func testBuild() async throws {
        DependencyInjection.shared.emptyContainer()
        let sut = HomeFactory()

        let result = sut.build()

        #expect(result == nil)
    }
}

@MainActor
@Suite("GIVEN a HomeFactory with DI registration")
struct HomeFactoryTestsWithDI {
    init() {
        DependencyInjection.shared.register(type: NetworkProtocol.self) {
            NetworkSpy()
        }

        DependencyInjection.shared.register(type: RouterProtocol.self) {
            RouterInterfaceSpy()
        }
    }

    @Test("WHEN build is called THEN it should return a HomeViewController")
    func testBuild() async throws {
        let sut = HomeFactory()

        let result = sut.build()

        #expect(result is HomeViewController)
    }
}
