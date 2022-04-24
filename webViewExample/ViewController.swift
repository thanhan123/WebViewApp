//
//  ViewController.swift
//  webViewExample
//
//  Created by dinh thanh an on 2022/04/05.
//

import WebKit
import UIKit

/**
 - Need to have special web pages to show in the native app
 - Predefine navigate behaviors in web -> the native app will check the event and do the navigation according to the web
 - Should we protect the native app web pages URL to be private only?
 - Saving web page content for using offline
 - Consider managing versions for web pages URL and app
 - Download config file for initial URLs like: home, profile, login,...
 */

class ViewController: UIViewController {
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [webView])
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  lazy var webView: WKWebView = {
    let webView = WKWebView()
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.navigationDelegate = self
    return webView
  }()

  let url: URL

  init(url: URL) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(stackView)
    view.backgroundColor = .white
    NSLayoutConstraint.activate(
      [
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
      ]
    )

    webView.load(URLRequest(url: url))
  }
}

extension ViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("call didFinish")
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("call didStartProvisionalNavigation")
  }

  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//    print("\(navigationAction.request.url): \(navigationAction.navigationType.rawValue)")
    switch navigationAction.navigationType {
//    case .formSubmitted:
//      if navigationAction.request.url?.absoluteString.contains("/cart/add") == true {
//        break
//      } else {
//        fallthrough
//      }
    case .linkActivated:
      if let url = navigationAction.request.url {
        decisionHandler(.cancel)
        navigationController?.pushViewController(ViewController(url: url), animated: true)
        return
      }
    default:
      break
    }
    decisionHandler(.allow)
  }
}
