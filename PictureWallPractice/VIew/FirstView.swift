//
//  FirstView.swift
//  PictureWallPractice
//
//  Created by Wang Sheng Ping on 2021/3/17.
//

import UIKit
import SnapKit

class FirstView: UIView {

    //MARK: - IBOutlets
    
    let myBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(myBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Layouts

    override func layoutSubviews() {
        myBtn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
    
}
