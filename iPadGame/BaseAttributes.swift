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
    var autoAttackDelay : Float
    
    // Core base attributes
    var agility : Int
    var charisma : Int
    var dexterity : Int
    var intelligence : Int
    var mind : Int
    var strength : Int
    var vitality : Int
    
    // Other attributes
    var defense : Float
    var enmity : Float
    var evasion : Float
    var magicAccuracy : Float
    var magicBlockRate : Float
    var magicDefense : Float
    var meleeAccuracy : Float
    var meleeBlockRate : Float
    var meleeDefense : Float
    
    internal init()
    {
        autoAttackDelay = 2.0
        
        agility = 2
        charisma = 2
        dexterity = 2
        intelligence = 2
        mind = 2
        strength = 2
        vitality = 2
        
        defense = 0.0
        enmity = 0.0
        evasion = 0.0
        magicAccuracy = 0.0
        magicBlockRate = 0.0
        magicDefense = 0.0
        meleeAccuracy = 0.0
        meleeBlockRate = 0.0
        meleeDefense = 0.0
        
    }
    
    //var timer : NSTimer! = nil
    
    //func StartTimer()
    //{
    //    timer = NSTimer.scheduledTimerWithTimeInterval(Double(attackDelay), target: self, selector: #selector(BaseAttributes.DebugPrint), userInfo: nil, repeats: true)
    //}
    
    func GetAutoAttackDelay() -> Float
    {
        return autoAttackDelay
    }
    
    func SetAutoAttackDelay(delay : Float)
    {
        autoAttackDelay = delay
    }
    
    //@objc func DebugPrint ()
    //{
    //    print ("Attacked")
    //}
}