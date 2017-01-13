//
//  GYLineView.swift
//  GYProgressLineAndCircleView
//
//  Created by ZGY on 2017/1/13.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/1/13  15:05
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit


fileprivate let PROGRESS_PADDING: CGFloat = 8
fileprivate let PROGRESS_TIPLABEL_HEIGHT: CGFloat = 30

class GYLineView: UIView {

    private enum ProgressLevelTextPosition {
        case Top
        case Bootom
        case None
    }
    
    var progressLevelArray = Array<String>()
    var pointMaxRadius:CGFloat?
    var lineMaxHeight: CGFloat?
    var currentLevel: Int?
    var animationDuration: CFTimeInterval?
    var unachievedColor: UIColor?
    var achievedColor: UIColor?
    
    private var aboveView: UIView!
    private var maskLayer: CAShapeLayer!
    private var moveLayer: CAShapeLayer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
                
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        
        initSubView(flag: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    private func initUI() {
        maskLayer = CAShapeLayer()
        
    }
    
    private func initSubView(flag: Bool) {
        
        guard progressLevelArray.count != 0 else {
            return
        }
        
        let height = self.frame.height - 2 * PROGRESS_PADDING
        
        let pointRadius = height > (pointMaxRadius ?? 0) ? pointMaxRadius : height / 2.0
        
        let lineHeight = height > (lineMaxHeight ?? 0) ? lineMaxHeight : height
        
        let unitLineWidth = (self.frame.width - 2 * PROGRESS_PADDING - 2 * pointRadius!) / CGFloat(self.progressLevelArray.count - 1)
        
        for i in 0 ..< self.progressLevelArray.count {
           
            let unitLineRect =  CGRect(x: PROGRESS_PADDING + CGFloat(i)  * unitLineWidth + pointRadius!, y: (self.frame.height - lineHeight!) / 2.0, width: unitLineWidth, height: lineHeight!)
            
            let pointRect = CGRect(x: PROGRESS_PADDING + CGFloat(i)  * unitLineWidth , y: self.frame.size.height / 2.0 - pointRadius!, width: 2 * pointRadius!, height: 2 * pointRadius!)
            
            var labelOriginY = self.frame.size.height / 2.0 - PROGRESS_PADDING - PROGRESS_TIPLABEL_HEIGHT - pointRadius!;
            
            let labelRect = CGRect(x: pointRect.minX + pointRadius! - unitLineWidth/2.0, y: labelOriginY, width: unitLineWidth, height: PROGRESS_TIPLABEL_HEIGHT)
            
            if i != self.progressLevelArray.count - 1 {
                
                if i < self.currentLevel! {
                    
                } else {
                    
                }
                
            }
            
            if  i <= self.currentLevel! {
                
            } else {
                
            }

        }
        
        
    }
    
    
    
    
}
