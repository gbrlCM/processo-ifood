//
//  WebViewController.swift
//  WebView
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import WebKit
import UIKit
import DesignSystem

final class WebViewController: LayoutableViewController, WKNavigationDelegate {
    private let webView: WKWebView
    private let url: URL

    init(url: URL) {
        self.webView = WKWebView()
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.title = webView.title
    }
}
