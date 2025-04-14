//
//  HomeFactory.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import HomeInterface
import UIKit

public final class HomeFactory: HomeFactoryProtocol {
    public init() {}
    
    public func build() -> UIViewController {
        HomeViewController()
    }
}
