//
//  PullRequestFactory.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import PullRequestInterface
import DependencyInjection
import Network
import UIKit
import Foundation
import RouterInterface

public final class PullRequestFactory: PullRequestFactoryProtocol {
    public init() {}

    public func build(params: URLComponents) -> UIViewController? {
        guard
            let network = DependencyInjection.shared.resolve(for: NetworkProtocol.self),
            let router = DependencyInjection.shared.resolve(for: RouterProtocol.self)
        else { return nil }
        let prRouter = PullRequestRouter(router: router)
        let repository = PullRequestRepository(initialPath: params.path, network: network)
        let reducer = PullRequestInteractor(repository: repository, router: prRouter, initialState: State())
        let presenter = PullRequestPresenter()
        let viewController = PullRequestViewController(reducer: reducer, presenter: presenter)
        prRouter.navigator = viewController
        return viewController
    }
}
