//
//  GYLineProgressView.swift
//  GYProgressLineAndCircleView
//
//  Created by ZGY on 2017/1/13.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/1/13  17:19
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

protocol GYLineProgressViewDataSource: NSObjectProtocol {
    
    
    /// 进度条数目
    ///
    /// - Returns: return value description
    func numberOfProgressInProgressView() -> NSInteger?
    
    
    /// 进度条标题
    ///
    /// - Parameters:
    ///   - progressView: progressView description
    ///   - titleAtIndex: titleAtIndex description
    /// - Returns: return value description
    func progressView(progressView: GYLineProgressView,titleAtIndex:NSInteger) -> String?

    
}


@objc protocol GYLineProgressViewDelegate {
    
    
    /// 圆的normal颜色(默认为灰色)
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func colorForCircleViewInProgressView(progressView: GYLineProgressView) -> UIColor?
    
    
    /// 圆的高亮颜色(默认红色)
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func highlightColorForCircleViewInProgressView(progressView:GYLineProgressView) -> UIColor?
    
    
    /// 标题的正常颜色(默认灰色)
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func colorForTitleViewInProgressView(progressView:GYLineProgressView) -> UIColor?

    /// 标题的高亮颜色(默认红色)
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func highlightColorForTitleViewInProgressView(progressView:GYLineProgressView) -> UIColor?
    
    
    /// 设置圆的半径，默认为10
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func radiusForCircleViewInProgressView(progressView:GYLineProgressView) -> CGFloat
    
    
    /// 设置标题的字体(默认12)
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func fontForTitleViewInProgressView(progressView:GYLineProgressView) -> UIFont?
    
    
    /// 设置标题的字体(默认12)
    ///
    /// - Parameter progressView: progressView description
    /// - Returns: return value description
    @objc optional func boldFontForTitleViewInProgressView(progressView:GYLineProgressView) -> UIFont?

    
    
    
}

fileprivate let DefaultRadius = 10

fileprivate let DefaultFont = UIFont.systemFont(ofSize: 12.0)

fileprivate let DefaultBoldFont = UIFont.systemFont(ofSize: 12.0)

fileprivate let DefaultCircleColor = UIColor.lightGray

fileprivate let DefaultTitleColor = UIColor.lightGray

fileprivate let DefaultHighCircleColor = UIColor.red

fileprivate let DefaultHighTitleColor = UIColor.red

class GYLineProgressView: UIView {
    
    weak var dataSource: GYLineProgressViewDataSource?
    weak var delegate: GYLineProgressViewDelegate?
    
    
    /// 未完成阶段
    var items: Array<Int>?
    {
        set {
            self.items = newValue
            for obj in items! {
                
                let number = obj - 1
                let label = self.titles?[number] as! UILabel
                label.textColor = titleNormalColor()
                
                let circleView = self.circles?[number] as! UIView
                circleView.backgroundColor = circleNormalColor()
                
            }
            
        }
        
        get {
            return self.items
        }
    }
    
    
    /// 当前进度
    var currentProgress: Int?
    {
        set {
            let numberOfProgress = self.dataSource?.numberOfProgressInProgressView()
            
            self.currentProgress = newValue
            if currentProgress! > numberOfProgress! {
                assert(true, "当前进度超出总进度")
                return
            }
            
            statusViewForCurrentProgress(currentProgress!)
            
            if (items != nil) && (items?.count)! > 0 {
                _ = self.items
            }
            
        }
        
        get {
            return self.currentProgress
        }
        
    }
    
    private var circles: Array<Any>?
    
    private var lines: Array<Any>?
    
    private var titles: Array<Any>?
    
    func reloadData() {
        
        self.circles?.forEach({ (view: UIView) in
            view.removeFromSuperview()
        } as! (Any) -> Void)
        self.circles?.removeAll()
        
        self.lines?.forEach({ (view: UIView) in
            view.removeFromSuperview()
        } as! (Any) -> Void)
        self.lines?.removeAll()
        
        self.titles?.forEach({ (view: UIView) in
            view.removeFromSuperview()
        } as! (Any) -> Void)
        self.titles?.removeAll()
        
        let numberOfProgress = dataSource?.numberOfProgressInProgressView()
        
        if numberOfProgress == 0 {
            return;
        }
        
        for i in 0..<Int(numberOfProgress!) {
            let title = dataSource?.progressView(progressView: self, titleAtIndex: i)
            let label = labelWithTitle(title)
            
            titles?.append(label)
            self.addSubview(label)
            
            let circleView = UIView()
            self.circles?.append(circleView)
            self.addSubview(circleView)
            
            if i != 0 {
                let lineView = UIView()
                self.lines?.append(lineView)
                self.addSubview(lineView)
                
            }
            
        }
        
    }
    
    
    fileprivate func statusViewForCurrentProgress(_ progress: Int) {
        
        let numberOfProgress = self.dataSource?.numberOfProgressInProgressView()
        
        let colorOfTItle = titleNormalColor()
        let colorOfCircle = circleNormalColor()
        
        for i in 0..<Int(numberOfProgress!) {
            
            let label = titles?[i] as! UILabel
            label.textColor = colorOfTItle
            label.font = fontForTitle()
            
            let circleView = circles?[i] as! UIView
            
            circleView.backgroundColor = colorOfCircle
            
            if i != 0 {
                let lineView = lines?[i - 1] as! UIView
                lineView.backgroundColor = colorOfCircle
                
            }
            
        }
        
        
        for i in 0..<currentProgress! {
            
            let label = titles?[i] as! UILabel
            label.textColor = titleHighColor()
            
            let circleView = circles?[i] as! UIView
            circleView.backgroundColor = circleHighColor()
            
            if i != 0 {
                let lineView = lines?[i - 1] as! UIView
                
                lineView.backgroundColor = circleHighColor()
                
            }
            
            if i == currentProgress! - 1 {
                
                label.textColor = titleHighColor()
                label.font = bodyFontForTitle()
                
            }
            
        }
        
    }
    
    
    fileprivate func titleNormalColor() -> UIColor? {
        
        if ((delegate?.colorForTitleViewInProgressView?(progressView: self)) != nil) {
            
            return delegate?.colorForTitleViewInProgressView!(progressView: self)
            
        }
        
        return DefaultTitleColor
    }

    fileprivate func circleNormalColor() -> UIColor?{
        
        if ((delegate?.colorForCircleViewInProgressView?(progressView: self)) != nil) {
            
            return delegate?.colorForCircleViewInProgressView!(progressView: self)
            
        }
        
        return DefaultCircleColor
        
    }
    
    fileprivate func fontForTitle() -> UIFont? {
        
        if ((self.delegate?.fontForTitleViewInProgressView?(progressView: self)) != nil){
            return delegate?.fontForTitleViewInProgressView!(progressView: self)
        }
        
        return DefaultFont
        
    }
    
    fileprivate func titleHighColor() -> UIColor? {
        
        if ((delegate?.highlightColorForTitleViewInProgressView?(progressView: self)) != nil) {
            
            return delegate?.highlightColorForTitleViewInProgressView!(progressView: self)
        }
        return DefaultHighTitleColor
    }
    
    fileprivate func circleHighColor() -> UIColor? {
        
        if ((delegate?.highlightColorForCircleViewInProgressView?(progressView: self)) != nil) {
            return delegate?.highlightColorForCircleViewInProgressView!(progressView: self)
        }
        
        return DefaultHighCircleColor
        
    }
    
    fileprivate func bodyFontForTitle() -> UIFont? {
     
        if delegate?.boldFontForTitleViewInProgressView?(progressView: self) != nil {
            return delegate?.boldFontForTitleViewInProgressView!(progressView: self)
        }
        
        return DefaultBoldFont
        
    }
    
    fileprivate func radiusForCircle() -> CGFloat {
        
        if ((delegate?.radiusForCircleViewInProgressView?(progressView: self)) != nil) {
            return (delegate?.radiusForCircleViewInProgressView!(progressView: self))!
        }
        return CGFloat(DefaultRadius)
    }
    
    fileprivate func labelWithTitle(_ title: String?) -> UILabel {
        
        let fontOfTitle = fontForTitle()
        let colorOfitle = titleNormalColor()
        
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.textColor = colorOfitle
        label.font = fontOfTitle
        
        return label
        
    }
    
    fileprivate func circleViewWithView(_ view: UIView) {
        
        let colorOfCircle = circleNormalColor()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = colorOfCircle
        
    }

    
    //MARK: - OVerride
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let numberOfProgress = dataSource?.numberOfProgressInProgressView()
        if  numberOfProgress == 0 {
            return
        }
        
        let marginLeft:CGFloat = 15.0
        let marginRight:CGFloat = 15.0
        let marginTop:CGFloat = 18.0
        let marginRow:CGFloat = 12.0
        
        let radiusOfCircle = radiusForCircle()
        let lineHeight = 2
        let lineWidth = ((self.frame.width - CGFloat(numberOfProgress!) * radiusOfCircle - marginLeft - marginRight) / (CGFloat(numberOfProgress!) - 1.0)) + 0.1
        
        let circleViewX = marginLeft
        
        for i in 0..<Int(numberOfProgress!) {
            
            let circleView = circles?[i] as! UIView
            
            circleView.frame = CGRect(x: circleViewX, y: marginTop, width: radiusOfCircle, height: radiusOfCircle)
            circleViewWithView(circleView)
            
            let label = titles?[i] as! UILabel
            
            if i == 0 {
                label.frame = CGRect(x: circleViewX, y: circleView.frame.maxY + marginRow, width: 0, height: 0)
                label.sizeToFit()
            } else if (i != numberOfProgress - 1) {
                label.sizeToFit()
                label.center = CGPoint(x: circleView.center.x, y: 0)
                label.frame = CGRect(x: label.frame.minX, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    override func willRemoveSubview(_ subview: UIView) {
        subview.willMove(toSuperview: subview)
        
        reloadData()
    }
    

}
