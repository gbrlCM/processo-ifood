//
//  ImageRepositorySpy.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import Network
import UIKit
import Foundation

public final actor ImageRepositorySpy: ImageRepositoryProtocol {
    public enum Method: Equatable, Sendable {
        case fetch(from: URL)
    }

    private var registeredImages: [URL: UIImage] = [:]
    public private(set) var methods: [Method] = []

    public init() {}

    public func fetch(from url: URL) async -> UIImage? {
        methods.append(.fetch(from: url))
        return registeredImages[url]
    }

    public func registerImage(key: URL, value: UIImage) async {
        registeredImages[key] = value
    }
}
