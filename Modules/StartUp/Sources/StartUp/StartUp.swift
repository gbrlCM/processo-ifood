import UIKit
import DependencyInjection
import RouterInterface

@MainActor
public enum StartUp {
    public static func buildWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.overrideUserInterfaceStyle = .light
        let router = DependencyInjection.shared.resolveUnwrapped(for: RouterProtocol.self)
        let viewController = router.view(for: HomeRoute())
        window.rootViewController = UINavigationController(rootViewController: viewController ?? UIViewController())
        return window
    }
}
