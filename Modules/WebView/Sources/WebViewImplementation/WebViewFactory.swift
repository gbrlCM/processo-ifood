//
//  WebViewFactory.swift
//  WebView
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Network
import UIKit
import Foundation
import WebViewInterface

public final class WebViewFactory: WebViewFactoryProtocol {
    public init() {}

    public func build(path: String) -> UIViewController? {
        var components = URLComponents()
        components.path = path

        guard let route = RouterBuilder(host: .web).build(for: components) else {
            return nil
        }

        return WebViewController(url: route)
    }
}
