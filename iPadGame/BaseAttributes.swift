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
    var attackDelay : Float
    var health : Int
    var strength : Int
    var vitality : Int
    
    
    
    internal init()
    {
        attackDelay = 2.0
        health = 30
        strength = 2
        vitality = 2
        
    }
    
    //var timer : NSTimer! = nil
    
    //func StartTimer()
    //{
    //    timer = NSTimer.scheduledTimerWithTimeInterval(Double(attackDelay), target: self, selector: #selector(BaseAttributes.DebugPrint), userInfo: nil, repeats: true)
    //}
    
    func GetAttackDelay() -> Float
    {
        return attackDelay
    }
    
    func SetAttackDelay(delay : Float)
    {
        attackDelay = delay
    }
    
    //@objc func DebugPrint ()
    //{
    //    print ("Attacked")
    //}
}