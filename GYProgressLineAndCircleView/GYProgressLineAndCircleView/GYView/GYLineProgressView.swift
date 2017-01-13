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

protocol GYLineProgressViewDataSource {
    
    
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


class GYLineProgressView: UIView {
    
    weak var dataSource: GYLineProgressViewDelegate!
    weak var delegate: GYLineProgressViewDelegate!
    
    
    /// 未完成阶段
    var items: Array<Int>?
    
    
    /// 当前进度
    var currentProgress: Int?
    
    


    
    

}
