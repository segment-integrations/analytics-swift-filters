//
//  TestUtils.swift
//  
//
//  Created by Brandon Sneed on 7/28/23.
//

import Foundation
import Segment

class OutputReaderPlugin: Plugin {
    let type: PluginType
    var analytics: Analytics?
    
    var events = [RawEvent]()
    var lastEvent: RawEvent? = nil
    
    init() {
        self.type = .after
    }
    
    func execute<T>(event: T?) -> T? where T : RawEvent {
        lastEvent = event
        if let t = lastEvent as? TrackEvent {
            events.append(t)
            print("EVENT: \(t.event)")
        }
        return event
    }
}

func waitUntilStarted(analytics: Analytics?) {
    guard let analytics = analytics else { return }
    // wait until the startup queue has emptied it's events.
    if let startupQueue = analytics.find(pluginType: StartupQueue.self) {
        while startupQueue.running != true {
            RunLoop.main.run(until: Date.distantPast)
        }
    }
}
