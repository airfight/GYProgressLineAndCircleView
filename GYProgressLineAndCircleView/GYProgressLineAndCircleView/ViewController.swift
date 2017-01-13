//
//  ViewController.swift
//  GYProgressLineAndCircleView
//
//  Created by zhuguangyang on 2017/1/13.
//  Copyright © 2017年 GYJade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fps = YYFPSLabel(frame:  CGRect(x: self.view.frame.maxX - 60, y: self.view.frame.maxY - 30, width: 60, height: 30))
        
        self.navigationController?.view.addSubview(fps)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

