//
//  TabViewController.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/12/1.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import UIKit
class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewMain = StoryData()
        viewMain.title = "新闻详情"
        let main = UINavigationController(rootViewController:viewMain)
        
        let commentsMain = Comments()
        commentsMain.title = "评论"
        let comments = UINavigationController(rootViewController: commentsMain)
        
        self.viewControllers = [main,comments]
        self.selectedIndex = 0
    }
}
