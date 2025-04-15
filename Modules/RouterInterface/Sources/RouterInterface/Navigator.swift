//
//  Navigator.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit

@MainActor
public protocol Navigator: AnyObject {
    func push(viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool)
    func pop()
    func popToRoot()
}

extension UIViewController: Navigator {
    public func present(viewController: UIViewController, animated: Bool) {
        navigationController?.present(viewController, animated: true)
    }

    public func pop() {
        navigationController?.pop()
    }

    public func popToRoot() {
        navigationController?.popToRoot()
    }

    public func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
