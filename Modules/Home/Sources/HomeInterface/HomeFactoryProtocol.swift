import UIKit

@MainActor
public protocol HomeFactoryProtocol {
    func build() -> UIViewController?
}
