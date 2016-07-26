//
//  LinkedList.swift
//  iPadGame
//
//  Created by Andrew Clear on 7/26/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation

public class LinkedListNode<T>
{
    var value : T
    var next : LinkedListNode?
    
    public init (value: T)
    {
        self.value = value
    }
}

public class LinkedList<T>
{
    public typealias Node = LinkedListNode<T>
    
    private var head : Node?
    
    public func add(value : T)
    {
        let newNode = Node(value: value)
        
        if (head == nil)
        {
            head = newNode
        }
        else
        {
            newNode.next = head
            head = newNode
        }
    }
    
    //public var isEmpty
    public func isEmpty() -> Bool
    {
        return head == nil
    }
    
    //public var first
    public func first() -> Node?
    {
        return head
    }
}
