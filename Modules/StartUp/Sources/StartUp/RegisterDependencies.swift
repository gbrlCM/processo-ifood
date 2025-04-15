//
//  RegisterDependencies.swift
//  StartUp
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import DependencyInjection
import Network
import RouterInterface
import RouterImplementation
import HomeInterface
import HomeImplementation
import PullRequestInterface
import PullRequestImplementation

extension StartUp {
    public static func registerDependencies() {
        DependencyInjection.shared.register(
            type: RouterProtocol.self
        ) {
            Router()
        }

        DependencyInjection.shared.register(type: HomeFactoryProtocol.self) {
            HomeFactory()
        }

        DependencyInjection.shared.register(type: NetworkProtocol.self) {
            Network()
        }

        DependencyInjection.shared.register(type: ImageRepositoryProtocol.self) {
            ImageRepository.shared
        }

        DependencyInjection.shared.register(type: PullRequestFactoryProtocol.self) {
            PullRequestFactory()
        }
    }
}
