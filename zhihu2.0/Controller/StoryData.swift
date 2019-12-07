//
//  File.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/11/27.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//
import UIKit
import WebKit
class StoryData: UIViewController, UITabBarDelegate{

    static var page: Int = 0
    var url: String?
    var webview = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        url = ViewController.storyURL[StoryData.page]
        webview = WKWebView(frame: CGRect(x: 0, y: 120, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 180))
        let Url = URL(string: url ?? "https://daily.zhihu.com/story/9717690")
        let request = URLRequest(url: Url!)
                webview.load(request)
                self.view.addSubview(self.webview)
//        print(StoryData.page)
        view.reloadInputViews()
    }
}

