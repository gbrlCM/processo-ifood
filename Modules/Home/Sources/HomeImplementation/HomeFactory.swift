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

    public func build() -> UIViewController {
        let network = DependencyInjection.shared.resolveUnwrapped(for: NetworkProtocol.self)
        let router = DependencyInjection.shared.resolveUnwrapped(for: RouterProtocol.self)
        let repository = HomeRepository(network: network)
        let homeRouter = HomeRouter(router: router)
        let interactor = HomeInteractor(repository: repository, router: homeRouter, initialState: State())
        let presenter = HomePresenter()
        let viewController = HomeViewController(reducer: interactor, presenter: presenter)
        homeRouter.navigator = viewController
        return viewController
    }
}
