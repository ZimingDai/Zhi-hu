//
//  URLsession.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/11/23.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//
import Alamofire

struct webRequest {
     
    static func alamofireGet(reload: @escaping(AllData) ->Void) {
    let dataRequest:DataRequest = Alamofire.request("https://news-at.zhihu.com/api/4/news/latest")
        dataRequest.responseJSON{data in
            switch data.result {
            case .success:
                print("数据获取成功!")
            case .failure(let error):
                print(error)
            }
            do {
                let allData = try JSONDecoder().decode(AllData.self, from: data.data!)
                reload(allData)
            }catch{
               print("error")
            }

        }
    }
}

struct webRequestY {
    static func alamofireGet(date: Int, reload: @escaping(NextNews) ->Void) {
        let D = date
        let url = "https://news-at.zhihu.com/api/4/news/before/"
    let dataRequest:DataRequest = Alamofire.request(url + String(D))
        dataRequest.responseJSON{data in
            switch data.result {
            case .success:
                print("数据获取成功!")
            case .failure(let error):
                print(error)
            }
            do {
                let nextdata = try JSONDecoder().decode(NextNews.self, from: data.data!)
                reload(nextdata)
            }catch{
               print("数据获取失败")
            }

        }
    }
}
struct CommetsRequest {

    static func alamofireGet(num: Int, reload: @escaping(LongComment) -> Void) {
        let Date = ViewController.ID[num]
        let url = "https://news-at.zhihu.com/api/4/story/" + String(Date) + "/long-comments"
        let dataRequest:DataRequest = Alamofire.request(url)
        dataRequest.responseJSON{ Data in
            do {
                let AllData = try JSONDecoder().decode(LongComment.self, from: Data.data!)
                reload(AllData)
            }catch {
                print("error")
            }
            
        }
    }
}

struct ShortCommetsRequest {

    static func alamofireGet(num: Int, reload: @escaping(ShortComment) -> Void) {
        let Date = ViewController.ID[num]
        let url = "https://news-at.zhihu.com/api/4/story/" + String(Date) + "/short-comments"
        let dataRequest:DataRequest = Alamofire.request(url)
        dataRequest.responseJSON{ Data in
            do {
                let AllData = try JSONDecoder().decode(ShortComment.self, from: Data.data!)
                reload(AllData)
            }catch {
                print("error")
            }
            
        }
    }
}
