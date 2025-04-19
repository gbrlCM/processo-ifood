//
//  FactorySpies.swift
//  RouterImplementation
//
//  Created by Lua Ferreira de Carvalho on 19/04/25.
//
import HomeInterface
import PullRequestInterface
import WebViewInterface
import UIKit

@MainActor
class FactorySpy {
    enum Method: Equatable, Sendable { case build }

    private(set) var methods: [Method] = []

    func build() -> UIViewController? {
        methods.append(.build)
        return UIViewController()
    }
}

class HomeFactorySpy: FactorySpy, HomeFactoryProtocol {}

class PullRequestFactorySpy: FactorySpy, PullRequestFactoryProtocol {
    func build(params: URLComponents) -> UIViewController? {
        build()
    }
}

class WebViewFactorySpy: FactorySpy, WebViewFactoryProtocol {
    func build(path: String) -> UIViewController? {
        build()
    }
}
