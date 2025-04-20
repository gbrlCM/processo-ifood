//
//  PullRequestRouterTests.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import RouterInterface
import RouterInterfaceTestHelpers
import Testing
import UIKit

@testable import PullRequestImplementation

@MainActor
@Suite("GIVEN a HomeRouter")
struct PullRequestRouterTests {
    let sut: PullRequestRouter
    let routerSpy: RouterInterfaceSpy
    let navigatorSpy: NavigatorSpy

    init() {
        routerSpy = RouterInterfaceSpy()
        navigatorSpy = NavigatorSpy()
        sut = PullRequestRouter(router: routerSpy)
        sut.navigator = navigatorSpy
    }

    @Test("WHEN webview is called and router has a view THEN it should push a new VC")
    func testWebViewSuccess() async throws {
        routerSpy.viewResponse = UIViewController()

        sut.webView(for: "/path")

        #expect(routerSpy.methods == [.view])
        #expect(navigatorSpy.methods == [.push])
    }

    @Test("WHEN webview is called and router has not a view THEN it should push a new VC")
    func testWebViewFailed() async throws {
        routerSpy.viewResponse = nil

        sut.webView(for: "/path")

        #expect(routerSpy.methods == [.view])
        #expect(navigatorSpy.methods.isEmpty)
    }

    @Test("WHEN error is called THEN it should present a new VC")
    func testError() async throws {
        sut.error(message: "", tryAgain: {})
        #expect(navigatorSpy.methods == [.present])
    }
}
