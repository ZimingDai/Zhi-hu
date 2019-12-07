//
//  ZhihuCell.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/12/7.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import UIKit
class Zhihucell: UITableViewCell {
    let photo = UIImageView()
    let author = UILabel()
    let content = UILabel()
    let time = UILabel()
    let fond = UIButton()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photo)
        contentView.addSubview(author)
        contentView.addSubview(time)
        contentView.addSubview(fond)
    }
    convenience init(){
       self.init(style:.default, reuseIdentifier: "cell")
        photo.frame = CGRect(x: 12, y: 12, width: 30, height: 30)
        photo.contentMode = UIView.ContentMode.scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 5
        
        author.frame = CGRect(x: 60, y: 14, width: 50, height: 16)
        author.font = .italicSystemFont(ofSize: 20)
        
        content.frame = CGRect(x: 0, y: author.frame.maxY + 10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        content.textColor = .darkGray
        content.font = .boldSystemFont(ofSize: 15)
        
        time.frame = CGRect(x: 0, y: content.frame.maxY + 5, width: 100, height: 30)
        time.textColor = .gray
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

