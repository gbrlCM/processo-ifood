import RouterInterface
import DependencyInjection
import HomeInterface
import PullRequestInterface
import UIKit

public final class Router: RouterProtocol {
    private let injector: DependencyInjectionProtocol

    public init(
        injector: DependencyInjectionProtocol = DependencyInjection.shared
    ) {
        self.injector = injector
    }

    public func view(for route: Route) -> UIViewController? {
        switch route.path {
        case HomeRoute.path:
            return injector.resolve(for: HomeFactoryProtocol.self)?.build()
        case PullRequestRoute.path:
            guard let path = route.query.first(where: { $0.name == "path"})?.value else { return nil }
            var components = URLComponents()
            components.path = path
            return injector.resolve(for: PullRequestFactoryProtocol.self)?.build(params: components)
        default:
            return nil
        }
    }
}
