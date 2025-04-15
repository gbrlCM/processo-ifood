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

public final class PullRequestFactory: PullRequestFactoryProtocol {
    public init() {}

    public func build(params: URLComponents) -> UIViewController? {
        guard
            let network = DependencyInjection.shared.resolve(for: NetworkProtocol.self)
        else { return nil }
        let repository = PullRequestRepository(initialPath: params.path, network: network)
        let reducer = PullRequestInteractor(repository: repository, initialState: State())
        let presenter = PullRequestPresenter()
        let viewController = PullRequestViewController(reducer: reducer, presenter: presenter)
        return viewController
    }
}
