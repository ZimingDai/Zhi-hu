//
//  Comments.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/12/1.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import UIKit
import MJRefresh
import Kingfisher
import WebKit

class Comments: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var CommentStruct: LongComment!
    var author: [String] = ["暂时还没有长评哟T_T"]
    var content: [String] = ["没有长评，怎么会有内容呢～"]
    var images: [String] = []
    var url:URL?
    static var page: Int = 0
    let scrollView = UIScrollView()
    let header = MJRefreshNormalHeader()
    var tableview = UITableView()
    var webview = WKWebView()
    override func viewDidLoad() {
        loadComments()
        print(Comments.page)
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height+100)
        view.addSubview(scrollView)
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerrefresh))
        header.setTitle("刷新中", for: .pulling)
        header.setTitle("刷新完成", for: .refreshing)
        self.scrollView.mj_header = header
        
        tableview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
        scrollView.addSubview(tableview)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return author.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identity: String = "reuse"
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identity)
        cell.textLabel?.text = author[indexPath.row]
//        url = URL(string: images[indexPath.row])
//        cell.imageView?.kf.indicatorType = .activity
//        cell.imageView?.kf.setImage(with: url)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = .italicSystemFont(ofSize: 30)
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.numberOfLines = 100
        cell.detailTextLabel?.text = content[indexPath.row]
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = .boldSystemFont(ofSize: 20)
        
        return cell
       }
    func loadComments(){
        CommetsRequest.alamofireGet(num: Comments.page) { Data in
            self.CommentStruct = Data
            var a = 0
            for title in self.CommentStruct.comments{
                if a == 0{self.author[0] = title.author}
                else {self.author.append(title.author)}
                if a == 0{self.content[0] = title.content}
                else {self.content.append(title.content)}
                self.content.append(title.content)
                self.images.append(title.avatar)
                a += 1
            }
            print(self.images)
            self.tableview.reloadData()
        }
    }
    @objc func headerrefresh(){
        self.tableview.reloadData()
        self.scrollView.reloadInputViews()
        self.scrollView.mj_header?.endRefreshing()
    }
}


