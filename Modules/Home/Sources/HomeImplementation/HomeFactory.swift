//
//  HomeFactory.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import HomeInterface
import DependencyInjection
import Network
import RouterInterface
import UIKit

public final class HomeFactory: HomeFactoryProtocol {
    public init() {}

    public func build() -> UIViewController? {
        guard let network = DependencyInjection.shared.resolve(for: NetworkProtocol.self),
              let router = DependencyInjection.shared.resolve(for: RouterProtocol.self)
        else {
            return nil
        }

        let repository = HomeRepository(network: network)
        let homeRouter = HomeRouter(router: router)
        let interactor = HomeInteractor(repository: repository, router: homeRouter, initialState: State())
        let presenter = HomePresenter()

        let viewController = HomeViewController(reducer: interactor, presenter: presenter)
        homeRouter.navigator = viewController
        return viewController
    }
}
