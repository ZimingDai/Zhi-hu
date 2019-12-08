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
    var commentStruct: LongComment!
    var shortCommentStruct: ShortComment!
    var Lauthor: [String] = ["暂时还没有长评哟T_T"]
    var Lcontent: [String] = ["没有长评，怎么会有内容呢～"]
    var Limages: [String] = ["https://pic2.zhimg.com/389eaec8db8901185931a224d9eac2b9_im.jpg"]
    var LUnixTime: [Int] = [1575243128]
    var LcommentTime: [String] = []
    let adHeaders: [String] = ["🐒长的评论", "賊短的评论"]
    var Sauthor: [String] = ["暂时还没有长评哟T_T"]
    var Scontent: [String] = ["没有长评，怎么会有内容呢～"]
    
    var url:URL?
    static var page: Int = 0
    let scrollView = UIScrollView()
    let header = MJRefreshNormalHeader()
    var tableview = UITableView(frame: .zero, style: .grouped)
    var webview = WKWebView()
    override func viewDidLoad() {
        loadComments()
        loadshortComment()
        super.viewDidLoad()
        
        var timeInterval: TimeInterval
        var date: Date
        var dformatter = DateFormatter()
        for i in 0..<LUnixTime.count{
            timeInterval = TimeInterval(LUnixTime[i])
            date = Date(timeIntervalSince1970: timeInterval)
            dformatter.dateFormat = "yyyy年MM月dd日 HH:mm"
            self.LcommentTime.append(dformatter.string(from: date))
        }
        
        view.backgroundColor = .white
//        MARK: -滚动视图
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height+100)
        view.addSubview(scrollView)
//        MARK: -上拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerrefresh))
        header.setTitle("刷新中", for: .pulling)
        header.setTitle("刷新完成", for: .refreshing)
        self.scrollView.mj_header = header
//        MARK: -tableview
        tableview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + 100)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
        scrollView.addSubview(tableview)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var a: Int
        if section == 0 {
            a = Lauthor.count
        }
        else {
            a = Sauthor.count
        }
        return a
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if CommentStruct.comments.isEmpty {
//            return 1
//        } else {
//            return 2
//        }
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return self.adHeaders[section]
    }
    
//       MARK: -tableview 设置
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identity: String = "reuse"
        var secno = indexPath.section
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identity)
        if secno == 0 {
        cell.textLabel?.text = Lauthor[indexPath.row]
        url = URL(string: self.Limages[indexPath.row])
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: url)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = .italicSystemFont(ofSize: 20)
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.numberOfLines = 100
        cell.detailTextLabel?.text = Lcontent[indexPath.row] + "\n" + "\n" + LcommentTime[indexPath.row]
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = .boldSystemFont(ofSize: 15)
        }
        else {
            cell.textLabel?.text = Sauthor[indexPath.row]
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            cell.detailTextLabel?.text = Scontent[indexPath.row]
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.numberOfLines = 30
            cell.detailTextLabel?.textColor = .gray
            cell.detailTextLabel?.font = .italicSystemFont(ofSize: 15)
        }
//        let cell = Zhihucell()
//        cell.author.text = author[indexPath.row]
//        cell.content.text = content[indexPath.row]
//        cell.time.text = "20191208"
        return cell
       }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        50
//    }
    func loadComments(){
        CommetsRequest.alamofireGet(num: Comments.page) { Data in
            self.commentStruct = Data
            var a = 0
            for title in self.commentStruct.comments{
                if a == 0{self.LUnixTime[0] = title.time}
                else {self.LUnixTime.append(title.time)}
                
                if a == 0{self.Lauthor[0] = title.author}
                else {self.Lauthor.append(title.author)}
                
                if a == 0{self.Lcontent[0] = title.content}
                else {self.Lcontent.append(title.content)}
                
                if a == 0{self.Limages[0] = title.avatar}
                else {self.Limages.append(title.avatar)}
                a += 1
            }
//            print(self.Limages)
//            print(self.LUnixTime)
            self.tableview.reloadData()
        }
    }
    @objc func headerrefresh(){
        self.tableview.reloadData()
        self.scrollView.reloadInputViews()
        self.scrollView.mj_header?.endRefreshing()
    }
    
    func loadshortComment() {
        ShortCommetsRequest.alamofireGet(num: Comments.page) { data in
            self.shortCommentStruct = data
            var a = 0
            for title in self.shortCommentStruct.comments{
                
                if a == 0{self.Sauthor[0] = title.author}
                else {self.Sauthor.append(title.author)}
                
                if a == 0{self.Scontent[0] = title.content}
                else {self.Scontent.append(title.content)}
                a += 1
            }
             self.tableview.reloadData()
        }
    }
}


