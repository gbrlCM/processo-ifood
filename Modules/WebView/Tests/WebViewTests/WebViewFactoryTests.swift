//
//  WebViewFactoryTests.swift
//  WebView
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import Foundation
import Testing

@testable import WebViewImplementation

@MainActor
@Test("GIVEN a WebViewFactory WHEN build is called THEN it should return a viewController")
func testBuild() async throws {
    let sut = WebViewFactory()

    let result = sut.build(path: "/path")

    #expect(result is WebViewController)
}
