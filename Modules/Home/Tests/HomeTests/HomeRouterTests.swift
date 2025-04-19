//
//  HomeRouterTests.swift
//  Home
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import RouterInterface
import RouterInterfaceTestHelpers
import Testing
import UIKit

@testable import HomeImplementation

@MainActor
@Suite("GIVEN a HomeRouter")
struct HomeRouterTests {
    let sut: HomeRouter
    let routerSpy: RouterInterfaceSpy
    let navigatorSpy: NavigatorSpy

    init() {
        routerSpy = RouterInterfaceSpy()
        navigatorSpy = NavigatorSpy()
        sut = HomeRouter(router: routerSpy)
        sut.navigator = navigatorSpy
    }

    @Test("WHEN pullRequests is called and router has a view THEN it should push a new VC")
    func testPullRequestSuccess() async throws {
        routerSpy.viewResponse = UIViewController()

        sut.pullRequests(path: "/path")

        #expect(routerSpy.methods == [.view])
        #expect(navigatorSpy.methods == [.push])
    }

    @Test("WHEN pullRequests is called and router has not a view THEN it should push a new VC")
    func testPullRequestFailed() async throws {
        routerSpy.viewResponse = nil

        sut.pullRequests(path: "/path")

        #expect(routerSpy.methods == [.view])
        #expect(navigatorSpy.methods.isEmpty)
    }

    @Test("WHEN error is called THEN it should present a new VC")
    func testError() async throws {
        sut.error(message: "", tryAgain: {})
        #expect(navigatorSpy.methods == [.present])
    }
}
