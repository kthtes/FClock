//
//  ClockView.swift
//  FClock
//
//  Created by Yi Yin on 2018/4/25.
//  Copyright © 2018年 Yi Yin. All rights reserved.
//

import UIKit

class ClockView: UIView {

    var hourAngle: CGFloat=0
    var minAngle: CGFloat=0
    var secAngle: CGFloat=0

    func update(hourAngle:Double, minAngle:Double, secAngle:Double){
        self.hourAngle=CGFloat(hourAngle)
        self.minAngle=CGFloat(minAngle)
        self.secAngle=CGFloat(secAngle)
        self.setNeedsDisplay()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext() {
            drawFrame(context: context)
            drawHand(context: context, length:0.6, angle:hourAngle)
            drawHand(context: context, length:0.8, angle:minAngle)
            drawHand(context: context, length:1.0, angle:secAngle)
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
    
    func drawHand(context:CGContext, length:CGFloat, angle:CGFloat) {
        let cx=self.frame.size.width/2.0
        let cy=self.frame.size.height/2.0
        let r=cx/2.0 * length
        context.move(to: CGPoint(x: cx, y: cy))
        context.addLine(to: CGPoint(x: cx+r*sin(angle), y: cy-r*cos(angle)))
        context.setLineWidth(2)
        context.strokePath()
    }
}
