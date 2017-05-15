//
//  ViewController.swift
//  GYProgressLineAndCircleView
//
//  Created by zhuguangyang on 2017/1/13.
//  Copyright © 2017年 GYJade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var arrTitls:Array<String>! = nil
    var subView:GYLineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fps = YYFPSLabel(frame:  CGRect(x: self.view.frame.maxX - 60, y: self.view.frame.maxY - 30, width: 60, height: 30))
        
        self.navigationController?.view.addSubview(fps)
        
//        view.backgroundColor = UIColor.init(hex: "0xFFEC8B")
        
        //此View未完善
//        arrTitls = ["你好","2","3","4"]
//        
//        
//        let progressView = GYLineProgressView()
//        progressView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 170)
//        progressView.delegate = self
//        progressView.dataSource = self
////        progressView.backgroundColor = UIColor.red
//        //
//        view.addSubview(progressView)
//        
//        progressView.reloadData()
//      
//         progressView.currentProgress = 0

        
        
        // 带进度标题的直线
        subView = GYLineView()
        subView.frame = CGRect(x: 10, y: 50, width: 300, height: 100)
        subView.progressLevelArray = ["1","2","3","4","5","6"];
        subView.lineMaxHeight = 4
        subView.pointMaxRadius = 6
        
        subView.textPosition = ProgressLevelTextPosition.Top
        subView.currentLevel = 7
        
        view.addSubview(subView)
        
//        subView.startAnimation()
        
        
        
        //渐变进度条
//        let progrssView = GYLineColorGradientView(frame: CGRect(x: 20.0, y: 100, width: 320 - 40, height: 45))
//        
//        progrssView.percent = 100
//        
//        self.view.addSubview(progrssView)
        

        
    }

    
    @IBAction func chageValue(_ sender: Any) {
        
        subView.currentLevel = 4
        subView.layoutSubviews()
        subView.startAnimation()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        subView.startAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: GYLineProgressViewDelegate,GYLineProgressViewDataSource {
    
    func numberOfProgressInProgressView() -> NSInteger? {
        
        return 4
    }
    
    func progressView(progressView: GYLineProgressView, titleAtIndex: NSInteger) -> String? {
        
        return arrTitls[titleAtIndex]
    }
    
    func highlightColorForCircleViewInProgressView(progressView: GYLineProgressView) -> UIColor? {
        
        return UIColor.blue
    }
    
}
