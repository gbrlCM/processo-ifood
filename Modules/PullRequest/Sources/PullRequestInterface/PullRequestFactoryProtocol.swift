//
//  PullRequestFactoryProtocol.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit
import Foundation

@MainActor
public protocol PullRequestFactoryProtocol {
    func build(params: URLComponents) -> UIViewController?
}
