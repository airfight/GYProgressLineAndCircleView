//
//  GYLineBtnProgreessView.swift
//  GYProgressLineAndCircleView
//
//  Created by ZGY on 2017/5/16.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/16  上午11:31
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

enum BtnType {
    
    case Unkown
    case checking
    case sucess
    
}

class GYLineBtnProgreessView: UIView {

    var shaperlayer: CAShapeLayer!
    var viewContainer:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shaperlayer = CAShapeLayer()
        viewContainer = UIView()
        
        self.addSubview(viewContainer)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
