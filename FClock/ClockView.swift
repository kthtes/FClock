//
//  ClockView.swift
//  FClock
//
//  Created by Yi Yin on 2018/4/25.
//  Copyright © 2018年 Yi Yin. All rights reserved.
//

import UIKit

class ClockView: UIView {
 
    let x0:CGFloat=0
    let y0:CGFloat=100
    
    func convertTime(hour:Int, min:Int, sec:Int, msec:Int) -> (percent:Double, hour:Int, min:Int, sec:Int){
        let current:Int = hour*3600000+min*60000+sec*1000+msec
        let percent:Double = Double(current) / Double(86400000)
        let fsec:Int = Int(65536*percent)
        return (percent, fsec/(64*64), fsec%(64*64)/64, fsec%64)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext() {
            drawFrame(context: context)
            // get current time
            let date=Date()
            let calendar=Calendar.current
            let (percent,hour,min,sec)=convertTime(
                hour: calendar.component(.hour, from: date),
                min: calendar.component(.minute, from: date),
                sec: calendar.component(.second, from: date),
                msec: calendar.component(.nanosecond, from: date)/1000000
            )
            //print("F Clock reads:",hour,min,sec)
            drawTime(context:context, percent:percent, hour:hour, min:min, sec:sec)
        }
    }

    func drawFrame(context:CGContext){
        let cx=self.frame.size.width/2.0
        let cy=self.frame.size.height/2.0
        let r=cx/2.0
        
        context.beginPath()
        context.setLineWidth(2)
        context.addArc(center: CGPoint(x: cx, y: cy), radius: r, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        context.strokePath()
    }
    
    func drawTime(context:CGContext, percent:Double, hour:Int, min:Int, sec:Int){
        let cx=self.frame.size.width/2.0
        let cy=self.frame.size.height/2.0
        let r=cx/2.0
        
        // draw hour
        context.move(to: CGPoint(x: cx, y: cy))
        var to=hand(cx: cx, cy: cy, radius: r*0.6, percent: percent)
        context.addLine(to: to)
        context.setLineWidth(2)
        context.strokePath()
        
        // draw min
        context.move(to: CGPoint(x: cx, y: cy))
        to=hand(cx: cx, cy: cy, radius: r*0.8, percent: Double(min)/64.0)
        context.addLine(to: to)
        context.setLineWidth(2)
        context.strokePath()

        // draw sec
        context.move(to: CGPoint(x: cx, y: cy))
        to=hand(cx: cx, cy: cy, radius: r, percent: Double(sec)/64.0)
        context.addLine(to: to)
        context.setLineWidth(2)
        context.strokePath()                
    }
    
    func hand(cx:CGFloat, cy:CGFloat, radius:CGFloat, percent:Double) -> CGPoint {
        let a=CGFloat(percent)*(.pi*2)
        return CGPoint(x:cx+radius*sin(a), y:cy-radius*cos(a))
    }
}
