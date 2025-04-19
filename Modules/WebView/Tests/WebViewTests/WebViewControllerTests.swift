//
//  WebViewControllerTests.swift
//  WebView
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import WebKit
import UIKit
import Testing

@testable import WebViewImplementation

@MainActor
@Suite("GIVEN a WebViewController")
struct WebViewControllerTests {
    let sut: WebViewController

    init() {
        let url = URL(string: "https://www.example.com/path")!
        sut = WebViewController(url: url)
    }

    @Test("WHEN webView decidePolicyFor is called with a URL without a correct host THEN it should forbid")
    func testWebViewForbid() async throws {
        let action = ActionPolicyMock()
        let forbiddenUrl = try #require(URL(string: "https://www.forbidden.com/path"))
        action.request = URLRequest(url: forbiddenUrl)

        let policy = await sut.webView(WKWebView(), decidePolicyFor: action)

        #expect(policy == .cancel)
    }

    @Test("WHEN webView decidePolicyFor is called with a URL a correct host THEN it should allow")
    func testWebViewAllow() async throws {
        let action = ActionPolicyMock()
        let forbiddenUrl = try #require(URL(string: "https://github.com/newpath"))
        action.request = URLRequest(url: forbiddenUrl)

        let policy = await sut.webView(WKWebView(), decidePolicyFor: action)

        #expect(policy == .allow)
    }
}
