//
//  ViewController.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/11/20.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import UIKit
import FSPagerView
import Alamofire
import Kingfisher


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,FSPagerViewDelegate, FSPagerViewDataSource {
    
//  MARK: -变量的定义。
    var Struct: AllData!
    var Struct2: AllData!
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    var image = FSPagerView()
    var storyImages: [String] = []
    static var storyTitles: [String] = []
    static var storyURL: [String] = []
    var topStoryImages: [String] = ["1", "2", "3", "1", "3"]
    var topStoryTitles: [String] = ["哎呀，电波没有到达～", "哎呀，电波没有到达～", "哎呀，电波没有到达～", "哎呀，电波没有到达～", "哎呀，电波没有到达～"]
    static var topStoryURL: [String] = []
    var hints: [String] = []
    static var ID: [Int] = []
    var tableview = UITableView()
    let scrollView = UIScrollView()
    var url:URL?
    var pagerControl = FSPageControl()
    
//    MARK: -viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
//        滚动视图
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height+100)
        view.addSubview(scrollView)
        
        view.backgroundColor = .white
//     MARK:-导航栏
        navigationItem.prompt = "苦逼作业QwQ"
        let hours = DateFormatter()
               hours.dateFormat = "HH"
               let time =  hours.string(from: Date())
               let intOfTime = Int(time)
               if intOfTime! > 18 && intOfTime! <= 23 {
                   navigationItem.title = "晚上好！"
               }
               else if intOfTime! > 4 && intOfTime! <= 10 {
                   navigationItem.title = "早上好！"
               }
               else if intOfTime! > 10 && intOfTime! <= 13 {
                   navigationItem.title = "中午好！"
               }
               else if intOfTime! > 13 && intOfTime! <= 18 {
                   navigationItem.title = "下午好！"
               }
               else if intOfTime! >= 0 && intOfTime! <= 4 {
                   navigationItem.title = "早点休息～"
               }
//        用户界面
//        let But1 = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//        But1.setImage(UIImage(named: "1"), for: .normal)
//        But1.setImage(UIImage(named: "2"), for: .highlighted)
//        let accountBut = UIBarButtonItem(customView: But1)
////        更改颜色。
//        let But2 = UIButton(frame: CGRect(x: 0, y: 0, width: 1, height: 18))
//        But2.setImage(UIImage(named: "night"), for: .normal)
//        But2.setImage(UIImage(named: "3"), for: .selected)
//        let accountBut2 = UIBarButtonItem(customView: But2)
////        间距
//        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
//                                         action: nil)
//               gap.width = 15
////        消除右边空隙
//        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
//                                     action: nil)
//        spacer.width = -10
//
//        self.navigationItem.rightBarButtonItems = [spacer,accountBut2,gap]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "跳转", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = true
        
//        MARK:-轮播图
        image.frame = CGRect(x: 0 , y: 0, width: view.bounds.width, height: 450)
        image.dataSource = self
        image.delegate = self
        image.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        image.automaticSlidingInterval = 3
        image.interitemSpacing = 3
        image.isInfinite = true
        image.transformer = FSPagerViewTransformer(type: FSPagerViewTransformerType.cubic)
        
        tableview.tableHeaderView = image
        
//       MARK:- 轮播图下角标。
//        pagerControl.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        pagerControl.numberOfPages = 5
//        pagerControl.contentHorizontalAlignment = .center
//        pagerControl.setStrokeColor(.black, for: .normal)
//        pagerControl.setStrokeColor(.orange, for: .selected)
//        pagerControl.setFillColor(.white, for: .normal)
//        pagerControl.setFillColor(.green, for: .selected)
//        pagerControl.setPath(UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: 5, height: 5),                 cornerRadius: 10.0), for: .normal)
        
//       MARK: -上拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerrefresh))
        header.setTitle("刷新中", for: .pulling)
        header.setTitle("刷新完成", for: .refreshing)
        self.scrollView.mj_header = header
        
//      MARK:-  下拉加载
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerrefresh))
        self.scrollView.mj_footer = footer
        
//       MARK:- tablewview定义
        tableview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height+100)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 60
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
        scrollView.addSubview(tableview)
        scrollView.addSubview(pagerControl)
    }
    
//    MARK: -tableview的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.storyTitles.count
    }
    
//    MARK:-tableview的样式。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identify: String = "reuse"
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identify)
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.textLabel?.numberOfLines = 3
                cell.textLabel?.text = ViewController.storyTitles[indexPath.row]
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        
                cell.detailTextLabel?.text = hints[indexPath.row]
                cell.detailTextLabel?.textColor = .gray
                url = URL(string: storyImages[indexPath.row])
                cell.imageView?.kf.indicatorType = .activity
                cell.imageView?.kf.setImage(with: url)
                return cell
    }
//   MARK:- 点击反应
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(TabViewController(), animated: true)
        StoryData.page = indexPath.row
        Comments.page = indexPath.row
    }
    

//    MARK:-轮播图的数量。
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
    }
    
//    MARK: -轮播图的定义
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
                let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
                url = URL(string: topStoryImages[index])
                cell.imageView?.image = UIImage(named: "1")
                cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: url)
                tableview.reloadData()
                cell.textLabel?.text = topStoryTitles[index]
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 300)
                cell.textLabel?.numberOfLines = 3
                cell.textLabel?.font = .italicSystemFont(ofSize: 20)
                return cell
    }

    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
                               pagerControl.currentPage = index
                           }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        TopStoryData.page = index
        navigationController?.pushViewController(TopStoryData(), animated: true)
        
    }
//    刷新函数
    @objc func headerrefresh(){
        self.tableview.reloadData()
        self.scrollView.reloadInputViews()
        self.scrollView.mj_header?.endRefreshing()
    }
//    加载函数
    @objc func footerrefresh(){
        loadData2()
        self.tableview.reloadData()
        self.scrollView.reloadInputViews()
        self.scrollView.mj_footer?.endRefreshingWithNoMoreData()
    }
//    MARK: -网络请求，刷新数组
    func loadData(){
        webRequest.alamofireGet { data in
            self.Struct = data
            var a = 0
            for topstory in self.Struct.topStories{
                self.topStoryTitles[a] = topstory.title
                self.topStoryImages[a] = topstory.image ?? "1"
                ViewController.topStoryURL.append(topstory.url)
                a += 1
            }
//            print(self.topStoryImages)
//            print("\n")
            for story in self.Struct.stories{
//                print(story.images!)
                ViewController.storyURL.append(story.url)
                ViewController.self.storyTitles.append(story.title)
                self.hints.append(story.hint)
                self.storyImages.append(story.images![0])
                ViewController.ID.append(story.id)
            }
            print(ViewController.self.ID)
//                print(ViewController.storyURL)
            self.tableview.reloadData()
        }
    }
    func loadData2(){
           webRequestY.alamofireGet(date: 20191203) { d in
               self.Struct2 = d
            for story in self.Struct2.stories{
                ViewController.storyURL.append(story.url)
                ViewController.self.storyTitles.append(story.title)
                self.hints.append(story.hint)
                self.storyImages.append(story.images![0])
            }
            print(self.title)
            self.tableview.reloadData()
        }
    }


}
