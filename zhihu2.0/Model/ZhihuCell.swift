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
    }
    convenience init(){
       self.init(style:.default, reuseIdentifier: "reuse")
        photo.frame = CGRect(x: 12, y: 12, width: 30, height: 30)
        photo.contentMode = UIView.ContentMode.scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 5
        
        author.frame = CGRect(x: 60, y: 14, width: UIScreen.main.bounds.width, height: 16)
        author.numberOfLines = 1
        author.font = .italicSystemFont(ofSize: 18)
        
        content.frame = CGRect(x: 20, y: author.frame.maxY + 5, width: UIScreen.main.bounds.width, height: 36)
        content.lineBreakMode = .byWordWrapping
        content.numberOfLines = 100
        content.textColor = .darkGray
        content.font = .boldSystemFont(ofSize: 15)
        
        time.frame = CGRect(x: 0, y: content.frame.maxY + 5, width: 100, height: 30)
        time.textColor = .gray
        contentView.addSubview(photo)
        contentView.addSubview(author)
        contentView.addSubview(time)
        contentView.addSubview(content)
        contentView.addSubview(fond)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

