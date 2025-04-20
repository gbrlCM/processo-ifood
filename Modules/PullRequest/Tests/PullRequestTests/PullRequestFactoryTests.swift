//
//  PullRequestFactoryTests.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import Network
import NetworkTestHelpers
import RouterInterface
import RouterInterfaceTestHelpers
import Testing
import Foundation

@testable import DependencyInjection
@testable import PullRequestImplementation

@MainActor
@Suite("GIVEN a Pull Factory without DI registration")
struct PullRequestFactoryTestsWithoutDI {
    @Test("WHEN build is called THEN it should return nil")
    func testBuild() async throws {
        DependencyInjection.shared.emptyContainer()
        let sut = PullRequestFactory()

        let result = sut.build(params: URLComponents())

        #expect(result == nil)
    }
}

@MainActor
@Suite("GIVEN a HomeFactory with DI registration")
struct PullRequestFactoryTestsWithDI {
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
        let sut = PullRequestFactory()

        let result = sut.build(params: URLComponents())

        #expect(result is PullRequestViewController)
    }
}
