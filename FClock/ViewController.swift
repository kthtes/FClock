//
//  ViewController.swift
//  FClock
//
//  Created by Yi Yin on 2018/4/25.
//  Copyright © 2018年 Yi Yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fclockView: ClockView!
    @IBOutlet weak var fclockLabel: UILabel!
    @IBOutlet weak var dclockView: ClockView!
    @IBOutlet weak var dclockLabel: UILabel!
    
    var timer=Timer()
    
    func scheduleTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (void) in
            // draw DClock and DLabel
            var (hour,min,sec,msec)=self.currentTime()
            var (hourAngle,minAngle,secAngle)=self.timeToAngle(hour:hour, min:min, sec:sec, hex:false)
            self.dclockView.update(hourAngle: hourAngle, minAngle: minAngle, secAngle: secAngle)
            self.dclockLabel.text=String(format:"Decimal Time: %02d:%02d.%02d", hour,min,sec)
            // draw FClock and FLabel
            (hour,min,sec)=self.timeToF(hour: hour, min: min, sec: sec, msec: msec)
            (hourAngle,minAngle,secAngle)=self.timeToAngle(hour:hour, min:min, sec:sec, hex:true)
            self.fclockView.update(hourAngle: hourAngle, minAngle: minAngle, secAngle: secAngle)
            self.fclockLabel.text=String(format:"Time: %02X:%02X.%02X", hour,min,sec)
        }
        timer.fire()
    }
    
    func currentTime() -> (hour:Int, min:Int, sec:Int, msec:Int) {
        let date=Date()
        let cal=Calendar.current
        return (
            cal.component(.hour, from: date),
            cal.component(.minute, from: date),
            cal.component(.second, from: date),
            cal.component(.nanosecond, from: date)/1000000
        )
    }
    
    func timeToF(hour:Int, min:Int, sec:Int, msec:Int) -> (hour:Int, min:Int, sec:Int) {
        let current:Int = hour*3600000+min*60000+sec*1000+msec
        let percent:Double = Double(current) / Double(86400000)
        let fsec:Int = Int(65536*percent)
        return (fsec/(64*64), fsec%(64*64)/64, fsec%64)
    }
    
    func timeToAngle(hour:Int, min:Int, sec:Int, hex:Bool) -> (hour:Double, min:Double, sec:Double) {
        if(hex){
            return (hour: Double(hour*64+min)/Double(16*64)*2.0*Double.pi,
                    min: Double(min*64+sec)/Double(64*64)*2.0*Double.pi,
                    sec: Double(sec)/Double(64)*2.0*Double.pi
            )
        }else{
            return (hour: Double(hour%12*60+min)/Double(12*60)*2.0*Double.pi,
                    min: Double(min*60+sec)/Double(60*60)*2.0*Double.pi,
                    sec: Double(sec)/Double(60)*2.0*Double.pi
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scheduleTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

