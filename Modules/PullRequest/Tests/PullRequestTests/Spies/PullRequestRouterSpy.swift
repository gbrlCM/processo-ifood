//
//  PullRequestRouterSpy.swift
//  PullRequest
//
//  Created by Lua Ferreira de Carvalho on 20/04/25.
//

import Models
import Foundation

@testable import PullRequestImplementation

final class PullRequestRouterSpy: PullRequestRouterProtocol {
    enum Method: Equatable, Sendable {
        case webView(path: String),
             share(url: String),
             error(message: String)
    }

    private(set) var methods: [Method] = []

    func webView(for path: String) {
        methods.append(.webView(path: path))
    }

    func share(for url: URL) {
        methods.append(.share(url: url.absoluteString))
    }

    func error(message: String, tryAgain: @escaping () -> Void) {
        methods.append(.error(message: message))
    }
}
