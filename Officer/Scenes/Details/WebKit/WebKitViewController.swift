//
//  WebKitViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 17.08.2022.
//

import UIKit
import WebKit


final class WebKitViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            if let url = URL(string: "https://www.mobven.com") {
                let urlRequest = URLRequest(url: url)
                DispatchQueue.main.async {
                    self.webView.load(urlRequest)
                }
                // Ekranın sağından solundan kaydırarak ileri geri navigasyonları göster
                webView.allowsBackForwardNavigationGestures = true
                webView.navigationDelegate = self
            }
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var progressView: UIProgressView!
    
    //Girdiğimiz site içerisinde olacağımız için ve tarayıcı barımız olmadığı için bir tane site yeter.
    var links = ["mobven.com"]
    
    
    
    // MARK: Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
        
        setRightBarButtonItem()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1.0 {
                progressView.isHidden = true
            } else {
                progressView.isHidden = false
            }
        }
    }
    
    
    
    
    //MARK: Custom Functions
    func setTabBarItems() {
        //Target: kim etkilenecek? webView'un kendi fonksiyonu olduğu için ekstra @objc func yazmamıza gerek kalmıyor.
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let backButton = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .done, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "greaterthan"), style: .done, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressItem = UIBarButtonItem(customView: progressView )
        
        toolbarItems = [backButton, spacer, progressItem, spacer, forwardButton]
        navigationController?.isToolbarHidden = false
    }
    
    func setRightBarButtonItem() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        navigationItem.rightBarButtonItems = [refresh]
    }
    
    func isIndicatorAnimating(show: Bool) {
        if show {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
}


//MARK: WebKit Delegates
extension WebKitViewController: WKNavigationDelegate {
    
    //Her Web sitesi yüklenmeye başladığında indicator başlayacak.
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isIndicatorAnimating(show: true)
    }
    
    //Her Web sitesinin yüklenmesi bittiğinde indicator duracak.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isIndicatorAnimating(show: false)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for link in links {
                if host.contains(link) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        getAlert(alertTitle: "Error!", actionTitle: "Terminate", message: "Access to Another Site Detected! Please stay at \(links[0])!")
    }
    
}



//links.forEach { link in
//    if host.contains(link) {
//        decisionHandler(.allow)
//        return
//    }
//
//}
