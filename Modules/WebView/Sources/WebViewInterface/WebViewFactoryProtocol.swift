//
//  WebViewFactoryProtocol.swift
//  WebView
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import UIKit

@MainActor
public protocol WebViewFactoryProtocol {
    func build(path: String) -> UIViewController?
}
