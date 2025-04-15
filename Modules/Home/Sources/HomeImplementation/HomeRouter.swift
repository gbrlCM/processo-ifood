//
//  HomeRouter.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation
import UIKit
import DesignSystem
import RouterInterface

@MainActor
protocol HomeRouterProtocol {
    func pullRequests(path: String)
    func error(message: String, tryAgain: @escaping () -> Void)
}

final class HomeRouter: HomeRouterProtocol {
    weak var navigator: Navigator?

    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    func pullRequests(path: String) {
        guard let viewController = router.view(for: PullRequestRoute(path: path)) else {
            return
        }

        navigator?.push(viewController: viewController, animated: true)
    }

    func error(message: String, tryAgain: @escaping () -> Void) {
        let viewController = DSErrorViewController()
        viewController.configure(title: "Error", message: message, buttonTitle: L10n.Error.button, onTap: tryAgain)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.sheetPresentationController?.detents = [.medium()]
        navigator?.present(viewController: navigationController, animated: true)
    }
}
