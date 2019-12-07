//
//  TopStoryData.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/11/29.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import UIKit
import WebKit
class TopStoryData: UIViewController {
    static var page: Int = 0
    var url: String?
    var webview = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        url = ViewController.topStoryURL[TopStoryData.page]
        webview = WKWebView(frame: CGRect(x: 0, y: 88, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 88))
        let Url = URL(string: url ?? "https://daily.zhihu.com/story/9717690")
        let request = URLRequest(url: Url!)
                webview.load(request)
                self.view.addSubview(self.webview)
//        print(TopStoryData.page)
        view.reloadInputViews()
    }
}
