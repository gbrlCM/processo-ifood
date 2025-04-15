//
//  HomeRouter.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation
import RouterInterface

@MainActor
protocol HomeRouterProtocol {
    func pullRequests(url: URL)
    func error(message: String, tryAgain: @escaping () -> Void)
}

final class HomeRouter: HomeRouterProtocol {
    weak var navigator: Navigator?

    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    func pullRequests(url: URL) {

    }

    func error(message: String, tryAgain: @escaping () -> Void) {
        
    }
}
