//
//  WikiWebviewViewController.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/28/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import UIKit

class WikiWebviewViewController: UIViewController,UIWebViewDelegate {

    var url:URL?
    
    @IBOutlet weak var webViewActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var wikiWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async(execute: { () -> Void in
            if let uri = self.url {
                self.wikiWebView.loadRequest(URLRequest(url:uri))
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.webViewActivityIndicator.stopAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.wikiWebView.delegate = nil
        self.wikiWebView.stopLoading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    // MARK: - WebView Delegate Method
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        // Ignore NSURLErrorDomain error -999.
        if (error as NSError?)?.code == NSURLErrorCancelled {
            return
        }
        // Ignore "Fame Load Interrupted" errors. Seen after app store links.
        if (error as NSError?)?.code == 102 && (error as NSError?)?.domain == "WebKitErrorDomain" {
            return
        }
        // Normal error handling…
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.webViewActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.webViewActivityIndicator.stopAnimating()
        print("\(String(describing: webView.request?.url))")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
