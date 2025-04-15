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
    func pullRequests(url: URL)
    func error(message: String, tryAgain: @escaping () -> Void)
}

final class HomeRouter: HomeRouterProtocol {
    weak var navigator: Navigator?

    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    func pullRequests(url: URL) {

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
