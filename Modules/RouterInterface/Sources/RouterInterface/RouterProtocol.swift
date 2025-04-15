import UIKit

@MainActor
public protocol RouterProtocol {
    func view(for route: Route) -> UIViewController?
}
