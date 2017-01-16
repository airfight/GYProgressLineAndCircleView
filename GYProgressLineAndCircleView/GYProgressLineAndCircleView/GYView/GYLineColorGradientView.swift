//
//  GYLineColorGradientView.swift
//  GYProgressLineAndCircleView
//
//  Created by ZGY on 2017/1/16.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/1/16  18:29
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

func printLog<T>(_ message: T,
                    file: String = #file,
                    method: String = #function,
                    line: Int = #line)
{
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
}


class GYLineColorGradientView: UIView {
    
    let kProcessHeight:CGFloat = 10
    let kTopSpaces: CGFloat = 5.0
    let kNumberMarkWidth: CGFloat = 60
    let kNumberMarkHeight: CGFloat = 20.0
    let kAnimationTime: CGFloat = 3.0
    
    var _percent:CGFloat?
    var percent: CGFloat?
    {
        set {
            setPercent(newValue!, animated: true)
            
        }
        get {
            return _percent
        }
    }
    
    private var maskLayer: CALayer?
    private var gradientLayer: CAGradientLayer?
    private var numberChangeTimer: Timer?
    private var numberPercent: CGFloat?
    
    
    /// 颜色组合
    private var colorArray: Array<Any>?
    
    /// 颜色渐变位置
    private var colorLocationArray: Array<Any>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        colorArray = [UIColor.init(hex: "0xFF6347").cgColor,
                      UIColor.init(hex: "0xFFEC8B").cgColor,
                      UIColor.init(hex: "0x98FB98").cgColor,
                      UIColor.init(hex: "0x00B2EE").cgColor,
                      UIColor.init(hex: "0x9400D3").cgColor]
        
        colorLocationArray = [(0.1),(0.3),(0.5),(0.7),(1)]
        
        numberMark?.frame = CGRect(x: 0, y: kTopSpaces, width: kNumberMarkWidth, height: kNumberMarkHeight)
        self.addSubview(numberMark!)
        
        setNUmberMarkLayer()
        getGradientLayer()
        
        self.numberPercent = 0
        
    }
    
    //MARK: - Method
    
    /// 提示文字设置渐变色
    fileprivate func setNUmberMarkLayer() {
        
        let numberGradientLayer = CAGradientLayer()
        numberGradientLayer.frame = CGRect(x: 0, y: kTopSpaces, width: self.frame.width, height: kNumberMarkHeight)
        numberGradientLayer.colors = colorArray
        numberGradientLayer.locations = colorLocationArray as! [NSNumber]?
        numberGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        numberGradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(numberGradientLayer)
        
        numberGradientLayer.mask = numberMark?.layer
        self.numberMark?.frame = numberGradientLayer.frame
        
    }
    
    
    /// 进度条设置渐变色
    fileprivate func getGradientLayer() {
        
        /// 灰色进度条背景
        let bgLayer = CALayer()
        bgLayer.frame = CGRect(x: kNumberMarkWidth / 2.0, y: self.frame.height - kProcessHeight - kTopSpaces, width: self.frame.width - kNumberMarkWidth / 2.0, height: kProcessHeight)
        printLog(bgLayer.frame)
        bgLayer.backgroundColor = UIColor.init(hex: "0xF5F5F5").cgColor
        bgLayer.masksToBounds = false
        bgLayer.cornerRadius = kProcessHeight / 2.0
        self.layer.addSublayer(bgLayer)
        
        self.maskLayer = CALayer()
        if _percent == nil {
            _percent = 0
        }
        self.maskLayer?.frame = CGRect(x: 0, y: 0, width: (self.frame.width - kNumberMarkWidth / 2.0) * (_percent! / 100.0), height: kProcessHeight)
        self.maskLayer?.borderWidth = self.frame.height / 2.0
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer?.frame = CGRect(x: kNumberMarkWidth / 2.0, y: self.frame.height - kProcessHeight - kTopSpaces, width: self.frame.width - kNumberMarkWidth / 2.0, height: kProcessHeight)
        self.gradientLayer?.masksToBounds = true
        self.gradientLayer?.cornerRadius = kProcessHeight / 2.0
        self.gradientLayer?.colors = self.colorArray
        self.gradientLayer?.locations = colorLocationArray as! [NSNumber]?
        self.gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        self.gradientLayer?.endPoint = CGPoint(x: 1, y: 0)
        self.gradientLayer?.mask = self.maskLayer
        self.layer.addSublayer(gradientLayer!)
        
    }
    
    fileprivate func setPercent(_ precent:CGFloat,animated: Bool) {
        
        _percent = precent
        
        Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(GYLineColorGradientView.circleAnimation), userInfo: nil, repeats: false)
        
        weak var weakSelf = self
        UIView.animate(withDuration: TimeInterval(kAnimationTime)) {
            
            weakSelf?.numberMark?.frame = CGRect(x: ((weakSelf?.frame.width)! - (weakSelf?.kNumberMarkWidth)!) * self._percent! / 100.0, y: 0, width: self.kNumberMarkWidth, height: self.kNumberMarkHeight)
            
        }
        self.numberChangeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GYLineColorGradientView.changeNumber), userInfo: nil, repeats: true)
        
    }
    
    func circleAnimation() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut))
        CATransaction.setAnimationDuration(CFTimeInterval(kAnimationTime))
        self.maskLayer?.frame = CGRect(x: 0, y: 0, width: (self.frame.width - kNumberMarkWidth / 2.0) * _percent! / 100.0, height: kProcessHeight)
        CATransaction.commit()
        
    }
    
    func changeNumber() {
        
        if (_percent == nil) {
            self.numberChangeTimer?.invalidate()
            self.numberChangeTimer = nil
        }
        
        self.numberPercent! += _percent! / (kAnimationTime * 10.0)
        
        if self.numberPercent! > _percent! {
            numberChangeTimer?.invalidate()
            numberChangeTimer = nil
            self.numberPercent = _percent
        }
        
        numberMark?.setTitle(String.init(NSString.init(format: "%0.1f", self.numberPercent!)) , for: UIControlState.normal)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 懒加载
    
    private lazy var numberMark: UIButton? = {
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("0%", for: UIControlState.normal)
        
        btn.setTitleColor(UIColor.init(hex: "0xFF6347"), for: UIControlState.normal)
        btn.setBackgroundImage(UIImage(named: "user_score_bubble"), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        btn.isEnabled = false
        
        return btn
        
    }()

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
