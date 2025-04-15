import Swinject

@MainActor
public protocol DependencyInjectionProtocol {
    func register<T>(
        type: T.Type,
        factory: @escaping () -> T
    )
    func resolve<T>(
        for type: T.Type
    ) -> T?

    func resolveUnwrapped<T>(
        for type: T.Type
    ) -> T
}

public final class DependencyInjection: DependencyInjectionProtocol {
    private let container: Container

    public static let shared = DependencyInjection(container: Container())

    init(container: Container) {
        self.container = container
    }

    public func register<T>(
        type: T.Type,
        factory: @escaping () -> T
    ) {
        container.register(type) { _ in
            factory()
        }
    }

    public func resolve<T>(
        for type: T.Type
    ) -> T? {
        container.resolve(type)
    }

    public func resolveUnwrapped<T>(
        for type: T.Type
    ) -> T {
        guard let service = container.resolve(type) else {
            preconditionFailure("Object of type \(type) could not be recovered")
        }

        return service
    }
}
