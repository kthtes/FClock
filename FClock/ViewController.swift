//
//  ViewController.swift
//  FClock
//
//  Created by Yi Yin on 2018/4/25.
//  Copyright © 2018年 Yi Yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer=Timer()
    
    func scheduleTimer() {
        timer=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.view.setNeedsDisplay()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        draw(view:self.view)
        scheduleTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func draw(view:UIView){
        
    }
}

