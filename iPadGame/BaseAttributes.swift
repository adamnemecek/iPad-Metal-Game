//
//  BaseAttributes.swift
//  iPadGame
//
//  Created by Andrew Clear on 7/25/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation

class BaseAttributes
{
    var attackDelay : Float = 2.0
    var timer : NSTimer! = nil
    
    func StartTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(attackDelay), target: self, selector: #selector(BaseAttributes.DebugPrint), userInfo: nil, repeats: true)
    }
    
    func GetAttackDelay() -> Float
    {
        return attackDelay
    }
    
    func SetAttackDelay(delay : Float)
    {
        attackDelay = delay
    }
    
    @objc func DebugPrint ()
    {
        print ("Attacked")
    }
}