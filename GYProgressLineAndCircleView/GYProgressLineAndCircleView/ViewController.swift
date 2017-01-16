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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fps = YYFPSLabel(frame:  CGRect(x: self.view.frame.maxX - 60, y: self.view.frame.maxY - 30, width: 60, height: 30))
        
        self.navigationController?.view.addSubview(fps)
        
        arrTitls = ["1","2","3","4"]
        
        
        let progressView = GYLineProgressView()
        progressView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 170)
        progressView.delegate = self
        progressView.dataSource = self
//        progressView.backgroundColor = UIColor.red
        //
        progressView.currentProgress = 2
        view.addSubview(progressView)
        
        progressView.reloadData()
      
        
        
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
