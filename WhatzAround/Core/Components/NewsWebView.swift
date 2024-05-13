//
//  NewsWebView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 09/05/2024.
//

import SwiftUI
import Foundation
import WebKit

struct NewsWebView: UIViewRepresentable {
    var urlString: String
    var webView = WKWebView()
 
    func makeCoordinator() -> Coordinator{
          Coordinator(self)
       }
    
    
    
    
    func makeUIView(context: Context) -> WKWebView  {
        
        guard let url = URL (string: urlString) else
        {return webView}
        
            webView.uiDelegate = context.coordinator
            webView.navigationDelegate = context.coordinator
        let request = URLRequest(url:url)
       
        webView.load(request)
            return webView
        }
    

    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func reload(){
            webView.reload()
        }
    
    }


class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {

    var parent: NewsWebView

    init(_ parent: NewsWebView){
        self.parent = parent
    }
  

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let exceptions = SecTrustCopyExceptions(serverTrust)
        SecTrustSetExceptions(serverTrust, exceptions)
        completionHandler(.useCredential, URLCredential(trust: serverTrust));
    }
    
     func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.parent.reload()
    }
}



