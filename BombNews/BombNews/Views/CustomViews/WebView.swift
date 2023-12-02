//
//  WebView..swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
import SwiftUI
import WebKit

// MARK: - WebView
struct WebView: UIViewRepresentable {
    let url: String?
    @Binding var showLoading: Bool
    
    func makeUIView(context: Context) -> some UIView {
        if let string = url, let url = URL(string: string) {
            let webView = WKWebView()
            webView.navigationDelegate = context.coordinator
            let request = URLRequest(url: url)
                webView.load(request)
            return webView
        } else {
            return WKWebView()
        }
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator {
            showLoading = true
        } didFinish: {
            showLoading = false
        }
    }
}

// MARK: - WebViewCoordinator
class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    var didStart: () -> Void
    var didFinish: () -> Void
    
    init(didStart: @escaping () -> Void,
         didFinish: @escaping () -> Void) {
        self.didStart = didStart
        self.didFinish = didFinish
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        didStart()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinish()
    }
}
