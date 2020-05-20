//
//  WebViewController.swift
//  URLRedirectDemo
//
//  Created by Tula Weerasooriya on 2020-05-20.
//  Copyright © 2020 Tula Weerasooriya. All rights reserved.
//

import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView?
    
    deinit {
        deinitWebView()
    }
    
    private func deinitWebView() {
        webView?.navigationDelegate = nil
        webView?.removeFromSuperview()
        webView = nil
    }
    
    private func initWebView() {
        deinitWebView()
        webView = WKWebView(frame: .zero)
        
        webView?.allowsLinkPreview = false
        webView?.navigationDelegate = self
        
        if let webView = webView {
            view.addSubview(webView)
            view.bringSubviewToFront(webView)
            setupWKWebViewConstraints(webView: webView)
        }
    }
    
    private func setupWKWebViewConstraints(webView: WKWebView) {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func errorOccurred(error: Error) {
        let lineNumber = #file + " line " + "\(#line)"
        print(lineNumber + ": " + error.localizedDescription)
    }
    
    // MARK: -
    
    func loadHTML(htmlString: String) {
        initWebView()
        webView?.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func loadURL(pageURL: URL?, timeoutInterval: TimeInterval = 10) {
        initWebView()
        guard let url = pageURL else {
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        webView?.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        errorOccurred(error: error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        errorOccurred(error: error)
    }
}

