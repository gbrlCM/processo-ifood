//
//  ActionPolicyMock.swift
//  WebView
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//

import WebKit

@MainActor
final class ActionPolicyMock: WKNavigationAction {
    override var request: URLRequest {
        get { _request }
        set { _request = newValue }
    }

    private var _request = URLRequest(
        url: URL.init(string: "https://www.example.com")!
    )
}
