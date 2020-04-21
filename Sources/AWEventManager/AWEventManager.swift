//
//  AWEventManager.swift
//  AWEventManager
//
//  Created by Tudor Ana on 02/02/2020.
//  Copyright © 2020 Tudor Ana. All rights reserved.
//

import Foundation

public class AWEventManager {
    
    public typealias EventBlock = () -> ()
    
    struct Event {
        var identifier: String!
        var event: EventBlock!
        var sender: AnyObject!
    }
    
    static var shared: AWEventManager = {
        return AWEventManager()
    }()
    
    private var events: [Event]? = []
    
}

extension AWEventManager {
    
    public static func send(event withName: String) {
        AWEventManager.shared.events?.forEach { (event) in
            if event.identifier == withName { event.event() }
        }
    }
    
    
    
    public static func listen(to eventName: String!,
                              from sender: AnyObject!,
                              _ block: @escaping EventBlock) {
        
        var contains = false
        AWEventManager.shared.events?.forEach { (event) in
            if event.identifier == eventName && event.sender === sender {
                contains = true
            }
        }
        
        guard !contains else { return }
        
        let event = Event(identifier: eventName, event: block, sender: sender)
        AWEventManager.shared.events?.append(event)
    }
    
    
    public static func remove(event withName: String,
                              sender: AnyObject) {
        var index: Int = 0
        AWEventManager.shared.events?.forEach { (event) in
            if event.identifier == withName &&
                event.sender === sender {
                AWEventManager.shared.events?.remove(at: index)
            }
            index += 1
        }
    }
    
    public static func removeAll(sender: AnyObject) {
        
        var index: Int = 0
        AWEventManager.shared.events?.forEach { (event) in
            if event.sender === sender {
                AWEventManager.shared.events?.remove(at: index)
            }
            index += 1
        }
    }
}
