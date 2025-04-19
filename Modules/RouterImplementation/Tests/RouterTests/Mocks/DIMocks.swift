//
//  DIMocks.swift
//  RouterImplementation
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import HomeInterface
import PullRequestInterface
import WebViewInterface
import RouterImplementation
@testable import DependencyInjection

@MainActor
enum DIMocks {
    static func register() {
        DependencyInjection.shared.emptyContainer()

        DependencyInjection.shared.register(type: HomeFactoryProtocol.self) {
            HomeFactorySpy()
        }

        DependencyInjection.shared.register(type: PullRequestFactoryProtocol.self) {
            PullRequestFactorySpy()
        }

        DependencyInjection.shared.register(type: WebViewFactoryProtocol.self) {
            WebViewFactorySpy()
        }
    }
}
