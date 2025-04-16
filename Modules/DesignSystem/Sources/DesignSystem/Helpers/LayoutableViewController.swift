//
//  LayoutableViewController.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import UIKit

open class LayoutableViewController: UIViewController, Layoutable {
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    open func setupHierarchy() {}
    open func setupLayout() {}
    open func setupStyle() {}

    open override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(named: Colors.accent)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: Colors.text)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        UIBarButtonItem.appearance().tintColor = UIColor(named: Colors.text)
    }
}
