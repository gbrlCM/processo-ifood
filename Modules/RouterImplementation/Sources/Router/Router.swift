import RouterInterface
import DependencyInjection
import HomeInterface
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
        default:
            return nil
        }
    }
}
