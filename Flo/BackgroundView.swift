//
//  BackgroundView.swift
//  Flo
//
//  Created by Kristofer Doman on 2015-07-20.
//  Copyright (c) 2015 Kristofer Doman. All rights reserved.
//

import UIKit

@IBDesignable class BackgroundView: UIView {

    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize:CGFloat = 200
    
    override func drawRect(rect: CGRect) {
        // UIGraphicsGetCurrentContext() gives you the view’s context and is also where drawRect(_:) draws
        let context = UIGraphicsGetCurrentContext()
        
        // Use the Core Graphics method CGContextSetFillColorWithColor() to set the current fill color of the context. Notice that you need to use CGColor, a property of darkColor when using Core Graphics
        CGContextSetFillColorWithColor(context, darkColor.CGColor)
        
        // Instead of setting up a rectangular path, CGContextFillRect() fills the entire context with the current fill color.
        CGContextFillRect(context, rect)
        
    
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        //set the fill color for the new context
        darkColor.setFill()
        CGContextFillRect(drawingContext,
            CGRectMake(0, 0, drawSize.width, drawSize.height))
        
        let trianglePath = UIBezierPath()
        
        trianglePath.moveToPoint(CGPoint(x:drawSize.width/2, y:0))
        trianglePath.addLineToPoint(CGPoint(x:0, y:drawSize.height/2))
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width, y:drawSize.height/2))
        trianglePath.moveToPoint(CGPoint(x: 0, y: drawSize.height/2))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2, y: drawSize.height))
        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height))
        trianglePath.moveToPoint(CGPoint(x: drawSize.width, y: drawSize.height/2))
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width/2, y:drawSize.height))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height))
        
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
