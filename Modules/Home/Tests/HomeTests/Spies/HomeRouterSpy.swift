//
//  HomeRouterSpy.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 17/04/25.
//

@testable import HomeImplementation

final class HomeRouterSpy: HomeRouterProtocol {
    enum Method: Equatable {
        case pullRequests(path: String)
        case error(message: String)
    }

    private(set) var methods: [Method] = []
    var tryAgainClosure: () -> Void = {}

    func pullRequests(path: String) {
        methods.append(.pullRequests(path: path))
    }

    func error(message: String, tryAgain: @escaping () -> Void) {
        methods.append(.error(message: message))
        tryAgainClosure = tryAgain
    }
}
