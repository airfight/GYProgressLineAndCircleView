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


public enum ProgressLevelTextPosition {
    case Top
    case Bootom
    case None
}


class GYLineView: UIView {

    var progressLevelArray = Array<String>()
    var pointMaxRadius:CGFloat?
    var lineMaxHeight: CGFloat?
    var currentLevel: Int?
    var animationDuration: CFTimeInterval?
    var textPosition: ProgressLevelTextPosition?
    
    /// 未完成进度颜色
    var unachievedColor: UIColor?
    /// 已完成进度颜色
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
        aboveView = UIView(frame: self.bounds)
        aboveView.backgroundColor = UIColor.clear
        maskLayer.frame = aboveView.bounds
        self.addSubview(aboveView)
        
        initSubView(flag: true)
        bringSubview(toFront: aboveView)
        configMask()
        
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
        
        if lineMaxHeight == nil {
            assert(false, "lineMaxHeight can't be nil")
        }
        
        if pointMaxRadius == nil {
            assert(false, "pointMaxRadius can't be nil")
        }
        
//        if <#condition#> {
//            <#code#>
//        }
        
        let pointRadius = height > (pointMaxRadius ?? 0) ? pointMaxRadius : height / 2.0
        
        let lineHeight = height > (lineMaxHeight ?? 0) ? lineMaxHeight : height
//        guard <#condition#> else {
//            <#statements#>
//        }
//        assert(false, "pointRadius can't be nil")
//        assert(false, " can't be nil")
        
        let unitLineWidth = (self.frame.width - 2 * PROGRESS_PADDING - 2 * pointRadius!) / CGFloat(self.progressLevelArray.count - 1)
        
        for i in 0 ..< self.progressLevelArray.count {
           
            let unitLineRect =  CGRect(x: PROGRESS_PADDING + CGFloat(i)  * unitLineWidth + pointRadius!, y: (self.frame.height - lineHeight!) / 2.0, width: unitLineWidth, height: lineHeight!)
            
            let pointRect = CGRect(x: PROGRESS_PADDING + CGFloat(i)  * unitLineWidth , y: self.frame.size.height / 2.0 - pointRadius!, width: 2 * pointRadius!, height: 2 * pointRadius!)
            
            var labelOriginY = self.frame.size.height / 2.0 - PROGRESS_PADDING - PROGRESS_TIPLABEL_HEIGHT - pointRadius!;
            
            if self.textPosition == .Bootom {
                
                labelOriginY = self.frame.height / 2.0 + PROGRESS_PADDING + pointRadius!
                
            }
            
//            if self.textPosition == ProgressLevelTextPosition.None {
//                labelOriginY = 0
//            }
            
            let labelRect = CGRect(x: pointRect.minX + pointRadius! - unitLineWidth/2.0, y: labelOriginY, width: unitLineWidth, height: PROGRESS_TIPLABEL_HEIGHT)
            
            if i != self.progressLevelArray.count - 1 {
                
                if (self.currentLevel == nil) {
                    self.currentLevel = 0
                }
                
                if i < self.currentLevel! {
                    
                    generateUnitLineWithFrame(unitLineRect, achievedFlag: true, aboveFlag: flag)
                    
                } else {
                     generateUnitLineWithFrame(unitLineRect, achievedFlag: false, aboveFlag: flag)
                }
                
            }
            
            if  i <= self.currentLevel! {
                
                generatePointWithFrame(pointRect, achievedFlag: true, aboveFlag: flag)
                
                if self.textPosition == ProgressLevelTextPosition.None {
            
                } else {
                    generateTipLabelWithFrame(labelRect, achievedFlag: true, text: self.progressLevelArray[i], aboveFlag: flag)
                }

            } else {

                generatePointWithFrame(pointRect, achievedFlag: false, aboveFlag: flag)
                if self.textPosition == ProgressLevelTextPosition.None {
                } else {
                    generateTipLabelWithFrame(labelRect, achievedFlag: false, text: self.progressLevelArray[i], aboveFlag: flag)
                }
          
            }

        }
        
        
    }
    
    fileprivate func generatePointWithFrame(_ frame: CGRect,achievedFlag: Bool,aboveFlag: Bool)
    {
        let pointView = UIView(frame: frame)
        
        if achievedFlag && aboveFlag {
            pointView.backgroundColor = (self.achievedColor != nil) ? self.achievedColor! : UIColor.orange
        } else {
            pointView.backgroundColor = (self.unachievedColor != nil) ? self.unachievedColor! : UIColor.lightGray
        }
        pointView.layer.cornerRadius = frame.size.width/2.0
        
        if aboveFlag {
            aboveView.addSubview(pointView)
        } else {
            self.addSubview(pointView)
        }
        
    }
    
    fileprivate func generateUnitLineWithFrame(_ frame: CGRect,achievedFlag: Bool,aboveFlag: Bool)
    {
        let lineView = UIView(frame: frame)
        
        if achievedFlag && aboveFlag {
            lineView.backgroundColor = (self.achievedColor != nil) ? self.achievedColor! : UIColor.orange
        } else {
            lineView.backgroundColor = (self.unachievedColor != nil) ? self.unachievedColor! : UIColor.lightGray
        }
        
        if aboveFlag {
            aboveView.addSubview(lineView)
        } else {
            self.addSubview(lineView)
        }
        
    }
    
    fileprivate func generateTipLabelWithFrame(_ frame:CGRect,achievedFlag: Bool,text: String,aboveFlag: Bool)
    {
        let tipLb = UILabel(frame: frame)
        tipLb.backgroundColor = UIColor.clear
        tipLb.text = text
        tipLb.adjustsFontSizeToFitWidth = true
        tipLb.baselineAdjustment = UIBaselineAdjustment.alignCenters
        tipLb.textAlignment = .center
        
        if achievedFlag && aboveFlag {
            tipLb.textColor = (self.achievedColor != nil) ? self.achievedColor! : UIColor.orange
        } else {
            tipLb.textColor = (self.unachievedColor != nil) ? self.unachievedColor! : UIColor.lightGray
        }
        
        if aboveFlag {
            aboveView.addSubview(tipLb)
        } else {
            self.addSubview(tipLb)
        }
        
    }
    
    fileprivate func configMask() {
        
        moveLayer = CAShapeLayer()
        moveLayer.bounds = aboveView.bounds
        moveLayer.fillColor = UIColor.black.cgColor
        moveLayer.path = UIBezierPath(rect: aboveView.bounds).cgPath
        moveLayer.opacity = 0.8
        moveLayer.position = CGPoint(x: -aboveView.bounds.width / 2.0, y: aboveView.bounds.height / 2.0)
        maskLayer.addSublayer(moveLayer)
        
        aboveView.layer.mask = maskLayer

    }
    
    func startAnimation() {
        
        moveLayer.position = CGPoint(x: aboveView.bounds.width / 2.0, y: aboveView.bounds.height / 2.0)
        let rightAnimation = CABasicAnimation(keyPath: "position")
        
        rightAnimation.fromValue = NSValue.init(cgPoint: CGPoint(x: -aboveView.bounds.width / 2.0, y: aboveView.bounds.height / 2.0))
        rightAnimation.toValue = NSValue.init(cgPoint: CGPoint(x: aboveView.bounds.width / 2.0, y: aboveView.bounds.height / 2.0))
        rightAnimation.duration = (self.animationDuration != nil) ? self.animationDuration! : 5.0
        rightAnimation.repeatCount = 0
        rightAnimation.isRemovedOnCompletion = false
        moveLayer.add(rightAnimation, forKey: "rightAnimation")
        
        
    }
    
    
    
}
