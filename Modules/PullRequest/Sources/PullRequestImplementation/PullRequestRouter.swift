//
//  PullRequestRouter.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation
import UIKit
import DesignSystem
import RouterInterface

@MainActor
protocol PullRequestRouterProtocol {
    func webView(for path: String)
    func share(for url: URL)
    func error(message: String, tryAgain: @escaping () -> Void)
}

final class PullRequestRouter: PullRequestRouterProtocol {
    weak var navigator: Navigator?

    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    func webView(for path: String) {
        guard let viewController = router.view(for: WebRoute(path: path)) else {
            return
        }

        navigator?.push(viewController: viewController, animated: true)
    }

    func share(for url: URL) {
        let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        navigator?.present(viewController: share, animated: true)
    }

    func error(message: String, tryAgain: @escaping () -> Void) {
        let viewController = DSErrorViewController()
        viewController.configure(title: "Error", message: message, buttonTitle: "", onTap: tryAgain)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.sheetPresentationController?.detents = [.medium()]
        navigator?.present(viewController: navigationController, animated: true)
    }
}
