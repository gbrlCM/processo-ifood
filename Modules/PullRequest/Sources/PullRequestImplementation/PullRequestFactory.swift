//
//  PullRequestFactory.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import PullRequestInterface
import UIKit
import Foundation

public final class PullRequestFactory: PullRequestFactoryProtocol {
    public init() {}

    public func build(params: URLComponents) -> UIViewController? {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .magenta
        return viewController
    }
}
